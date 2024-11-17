with Ada.Real_Time;  -- Asegúrate de que esta unidad está importada correctamente
with Ada.Text_IO;
with devicesFSS_V1;
with datos_aeronave;
with datos_posalt_vel;

package control_detector_obstaculos is

   -- Definición de constantes de tiempo utilizando Standard.Duration
   Tiempo_Alarma                     : constant Standard.Duration := 10.0;  -- 10 segundos
   Tiempo_Desvio_Visibilidad_Baja    : constant Standard.Duration := 10.0;  -- 10 segundos (visibilidad baja)
   Tiempo_Visibilidad_Baja           : constant Standard.Duration := 15.0; -- 15 segundos (visibilidad baja)
   Tiempo_Desvio                     : constant Standard.Duration := 5.0;  -- 5 segundos para maniobra de desvío
   
   -- Declaración del objeto protegido para control de desvío
   protected Desvio_Control is
      procedure Activate_Desvio;
      function Is_Desvio_Active return Boolean;
      procedure Reset_Desvio;
   private
      Desvio_Active : Boolean := False;
   end Desvio_Control;

   -- Declaración de la tarea combinada Control_Obstaculos
   task Control_Obstaculos is
      pragma Priority (19);
   end Control_Obstaculos;

end control_detector_obstaculos;
