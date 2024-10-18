-- detector_obstaculos.ads
-- Especificación para el sistema de detección de obstáculos y maniobra de desvío usando tasks

package Detector_Obstaculos is

   -- Tipo que representa la distancia al obstáculo
   type Distancia_Tipo is range 0 .. 10000;

   -- Tipo que representa la velocidad de la nave
   type Velocidad_Tipo is range 0 .. 1000; -- En metros por segundo

   -- Tipo que representa la altitud de la nave
   type Altitud_Tipo is range 0 .. 15000; -- En metros

   -- Tipo que representa la visibilidad actual
   type Visibilidad_Tipo is range 0 .. 1000; -- En metros

   -- Task que maneja la detección de obstáculos cada 250 ms
   task type Task_Deteccion is
      entry Configurar_Deteccion(
         Distancia    : Distancia_Tipo;
         Velocidad    : Velocidad_Tipo;
         Altitud      : Altitud_Tipo;
         Visibilidad  : Visibilidad_Tipo;
         Piloto_Presente : Boolean
      );
   end Task_Deteccion;

   -- Task que maneja el cálculo de tiempo hasta la colisión
   task type Task_Tiempo_Colision is
      entry Calcular(Distancia : Distancia_Tipo; Velocidad : Velocidad_Tipo);
   end Task_Tiempo_Colision;

   -- Task que maneja la alarma sonora
   task type Task_Alarma is
      entry Activar(Volumen : Integer);
   end Task_Alarma;

   -- Task que maneja la maniobra de desvío
   task type Task_Maniobra_Desvio is
      entry Iniciar(Altitud : Altitud_Tipo);
   end Task_Maniobra_Desvio;

end Detector_Obstaculos;
