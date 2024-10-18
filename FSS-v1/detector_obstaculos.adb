-- detector_obstaculos.adb
-- Implementación para el sistema de detección de obstáculos y maniobra de desvío

with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO;    use Ada.Text_IO;

package body Detector_Obstaculos is

   -- Valor umbral para considerar que no hay obstáculo
   No_Obstaculo_Threshold : constant Distancia_Tipo := 5000;

   -- Constantes de tiempo
   Aviso_Alarma_Seg : constant Float := 10.0;
   Desvio_Seg       : constant Float := 5.0;
   Aviso_Visibilidad_Seg : constant Float := 15.0;
   Desvio_Visibilidad_Seg : constant Float := 10.0;

   -- Tiempo en milisegundos para la detección de obstáculos
   Intervalo_Deteccion : constant Time_Span := Milliseconds(250);
   Plazo_Maniobra_Max  : constant Time_Span := Milliseconds(80);

   -- Incrementa el cabeceo de la nave
   Cabeceo_Incremento : constant Integer := 20;
   -- Realiza un alabeo de 45 grados a la derecha
   Alabeo_Derecha : constant Integer := 45;

   -- Función que determina si hay un obstáculo
   function Hay_Obstaculo(Distancia : Distancia_Tipo) return Boolean is
   begin
      return Distancia < No_Obstaculo_Threshold;
   end Hay_Obstaculo;

   -- Procedimiento que calcula el tiempo hasta la colisión
   procedure Calcular_Tiempo_Colision(
      Distancia : Distancia_Tipo;
      Velocidad : Velocidad_Tipo;
      Tiempo    : out Float
   ) is
   begin
      if Velocidad > 0 then
         Tiempo := Float(Distancia) / Float(Velocidad);
      else
         Tiempo := Float'Last; -- Infinito si la velocidad es cero
      end if;
   end Calcular_Tiempo_Colision;

   -- Procedimiento que genera una alarma sonora
   procedure Alarma_Sonora(Volumen : Integer) is
   begin
      Put_Line("Alarma Sonora Activada con Volumen: " & Integer'Image(Volumen));
   end Alarma_Sonora;

   -- Procedimiento que inicia la maniobra de desvío
   procedure Maniobra_Desvio(Altitud : Altitud_Tipo) is
   begin
      if Altitud <= 8500 then
         Put_Line("Incrementando Cabeceo a 20 grados durante 3 segundos");
         delay 3.0;
         Put_Line("Estabilizando cabeceo");
      else
         Put_Line("Realizando alabeo de 45 grados a la derecha durante 3 segundos");
         delay 3.0;
         Put_Line("Estabilizando alabeo");
      end if;
   end Maniobra_Desvio;

   -- Procedimiento principal para detectar obstáculos y realizar acciones necesarias
   procedure Detectar_Obstaculos(
      Distancia       : Distancia_Tipo;
      Velocidad       : Velocidad_Tipo;
      Altitud         : Altitud_Tipo;
      Visibilidad     : Visibilidad_Tipo;
      Piloto_Presente : Boolean
   ) is
      Tiempo_Colision : Float;
   begin
      if Hay_Obstaculo(Distancia) then
         Calcular_Tiempo_Colision(Distancia, Velocidad, Tiempo_Colision);

         if Visibilidad < 500 or else not Piloto_Presente then
            if Tiempo_Colision <= Aviso_Visibilidad_Seg then
               Alarma_Sonora(4);
            end if;
            if Tiempo_Colision <= Desvio_Visibilidad_Seg then
               delay Plazo_Maniobra_Max;
               Maniobra_Desvio(Altitud);
            end if;
         else
            if Tiempo_Colision <= Aviso_Alarma_Seg then
               Alarma_Sonora(4);
            end if;
            if Tiempo_Colision <= Desvio_Seg then
               delay Plazo_Maniobra_Max;
               Maniobra_Desvio(Altitud);
            end if;
         end if;
      else
         Put_Line("No hay obstáculos detectados.");
      end if;
   end Detectar_Obstaculos;

end Detector_Obstaculos;
