-- detector_obstaculos.adb
-- Implementación para el sistema de detección de obstáculos y maniobra de desvío usando tasks

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

   -- Task que maneja la detección de obstáculos
   task body Task_Deteccion is
      Distancia       : Distancia_Tipo := 0;
      Velocidad       : Velocidad_Tipo := 0;
      Altitud         : Altitud_Tipo := 0;
      Visibilidad     : Visibilidad_Tipo := 0;
      Piloto_Presente : Boolean := False;
      Tiempo_Colision : Float := 0.0;
   begin
      loop
         delay Intervalo_Deteccion;
         -- Detectar si hay obstáculo
         if Distancia < No_Obstaculo_Threshold then
            -- Llamar al task de tiempo de colisión
            Task_Tiempo_Colision.Calcular(Distancia, Velocidad);
            accept Configurar_Deteccion(
               Nueva_Distancia    : Distancia_Tipo;
               Nueva_Velocidad    : Velocidad_Tipo;
               Nueva_Altitud      : Altitud_Tipo;
               Nueva_Visibilidad  : Visibilidad_Tipo;
               Nuevo_Piloto_Presente : Boolean
            ) do
               Distancia       := Nueva_Distancia;
               Velocidad       := Nueva_Velocidad;
               Altitud         := Nueva_Altitud;
               Visibilidad     := Nueva_Visibilidad;
               Piloto_Presente := Nuevo_Piloto_Presente;
            end Configurar_Deteccion;
         else
            Put_Line("No hay obstáculos detectados.");
         end if;
      end loop;
   end Task_Deteccion;

   -- Task que maneja el cálculo del tiempo hasta la colisión
   task body Task_Tiempo_Colision is
      Tiempo_Colision : Float := 0.0;
   begin
      accept Calcular(Distancia : Distancia_Tipo; Velocidad : Velocidad_Tipo) do
         if Velocidad > 0 then
            Tiempo_Colision := Float(Distancia) / Float(Velocidad);
         else
            Tiempo_Colision := Float'Last; -- Infinito si la velocidad es cero
         end if;
      end Calcular;

      -- Dependiendo del tiempo de colisión, activar la alarma o iniciar maniobra
      if Tiempo_Colision <= Aviso_Visibilidad_Seg or else Tiempo_Colision <= Aviso_Alarma_Seg then
         Task_Alarma.Activar(4);
      end if;

      if Tiempo_Colision <= Desvio_Visibilidad_Seg or else Tiempo_Colision <= Desvio_Seg then
         delay Plazo_Maniobra_Max;
         Task_Maniobra_Desvio.Iniciar(Altitud => 8500); -- Ejemplo con una altitud fija
      end if;
   end Task_Tiempo_Colision;

   -- Task que maneja la alarma sonora
   task body Task_Alarma is
   begin
      accept Activar(Volumen : Integer) do
         Put_Line("Alarma Sonora Activada con Volumen: " & Integer'Image(Volumen));
      end Activar;
   end Task_Alarma;

   -- Task que maneja la maniobra de desvío
   task body Task_Maniobra_Desvio is
   begin
      accept Iniciar(Altitud : Altitud_Tipo) do
         if Altitud <= 8500 then
            Put_Line("Incrementando Cabeceo a 20 grados durante 3 segundos");
            delay 3.0;
            Put_Line("Estabilizando cabeceo");
         else
            Put_Line("Realizando alabeo de 45 grados a la derecha durante 3 segundos");
            delay 3.0;
            Put_Line("Estabilizando alabeo");
         end if;
      end Iniciar;
   end Task_Maniobra_Desvio;

end Detector_Obstaculos;
