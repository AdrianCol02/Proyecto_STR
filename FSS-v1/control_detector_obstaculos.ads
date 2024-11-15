with Ada.Real_Time;
with devicesFSS_V1;
with datos_posalt_vel; 

package control_detector_obstaculos is

   -- Constantes
   Max_Distancia_Sin_Obstaculo : constant devicesFSS_V1.Distance_Samples_Type := 5000;
   Tiempo_Alarma               : constant Duration := 10.0;
   Tiempo_Desvio               : constant Duration := 5.0;
   Tiempo_Visibilidad_Baja     : constant Duration := 15.0;
   Tiempo_Desvio_Visibilidad_Baja : constant Duration := 10.0;
   Periodo_Deteccion           : constant Duration := 0.25;  -- 250 ms

   -- Declaración de tareas
   task type Supervisor_Obstaculos;

   task type Desviador_Obstaculos is
      entry Set_Desvio;
   end Desviador_Obstaculos;

end control_detector_obstaculos;
