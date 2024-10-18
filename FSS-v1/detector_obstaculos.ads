-- detector_obstaculos.ads
-- Especificación para el sistema de detección de obstáculos y maniobra de desvío

package Detector_Obstaculos is

   -- Tipo que representa la distancia al obstáculo
   type Distancia_Tipo is range 0 .. 10000;

   -- Tipo que representa la velocidad de la nave
   type Velocidad_Tipo is range 0 .. 1000; -- En metros por segundo

   -- Tipo que representa la altitud de la nave
   type Altitud_Tipo is range 0 .. 15000; -- En metros

   -- Tipo que representa la visibilidad actual
   type Visibilidad_Tipo is range 0 .. 1000; -- En metros

   -- Función que determina si hay un obstáculo
   function Hay_Obstaculo(Distancia : Distancia_Tipo) return Boolean;

   -- Procedimiento que calcula el tiempo hasta la colisión
   procedure Calcular_Tiempo_Colision(
      Distancia : Distancia_Tipo;
      Velocidad : Velocidad_Tipo;
      Tiempo    : out Float
   );

   -- Procedimiento que genera una alarma sonora
   procedure Alarma_Sonora(Volumen : Integer);

   -- Procedimiento que inicia la maniobra de desvío
   procedure Maniobra_Desvio(Altitud : Altitud_Tipo);

   -- Procedimiento principal para detectar obstáculos y realizar acciones necesarias
   procedure Detectar_Obstaculos(
      Distancia    : Distancia_Tipo;
      Velocidad    : Velocidad_Tipo;
      Altitud      : Altitud_Tipo;
      Visibilidad  : Visibilidad_Tipo;
      Piloto_Presente : Boolean
   );

end Detector_Obstaculos;
