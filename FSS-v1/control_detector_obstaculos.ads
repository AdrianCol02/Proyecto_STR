with Ada.Real_Time;
with datos_posalt_vel;  -- Incluir el paquete que proporciona las funciones de lectura de Pitch y Roll

package control_detector_obstaculos is
   -- Declaración de tiempos y constantes
   Tiempo_Desvio_Visibilidad_Baja : constant Duration := 5.0;
   Tiempo_Visibilidad_Baja        : constant Duration := 10.0;
   Tiempo_Desvio                  : constant Duration := 7.0;
   Tiempo_Alarma                  : constant Duration := 15.0;
   Periodo_Deteccion              : constant Duration := 0.250;

   -- Protected object para control de desvío
   protected Desvio_Control is
      procedure Activate_Desvio;
      function Is_Desvio_Active return Boolean;
      procedure Reset_Desvio;
   private
      Desvio_Active : Boolean := False;
   end Desvio_Control;

   -- Tareas
   task Supervisor_Obstaculos;
   task Desviador_Obstaculos;

end control_detector_obstaculos;
