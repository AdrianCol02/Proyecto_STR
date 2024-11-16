with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;
with datos_posalt_vel;

package body control_detector_obstaculos is

   -- Implementación del objeto protegido
   protected body Desvio_Control is
      procedure Activate_Desvio is
      begin
         Desvio_Active := True;
      end Activate_Desvio;

      function Is_Desvio_Active return Boolean is
      begin
         return Desvio_Active;
      end Is_Desvio_Active;

      procedure Reset_Desvio is
      begin
         Desvio_Active := False;
      end Reset_Desvio;
   end Desvio_Control;

   -- Implementación de la tarea Supervisor_Obstaculos
   task body Supervisor_Obstaculos is
      Distancia       : devicesFSS_V1.Distance_Samples_Type;
      Velocidad       : devicesFSS_V1.Speed_Samples_Type;
      Altitud         : devicesFSS_V1.Altitude_Samples_Type;
      Visibilidad     : devicesFSS_V1.Light_Samples_Type;
      Piloto_Presente : devicesFSS_V1.PilotPresence_Samples_Type;
      Joystick        : devicesFSS_V1.Joystick_Samples_Type;
      Tiempo_Colision : Duration;
      Next_Time       : Ada.Real_Time.Time := Ada.Real_Time.Clock;
   begin
      loop
         -- Leer datos de sensores
         devicesFSS_V1.Read_Distance(Distancia);
         datos_posalt_vel.Datos_Vuelo.Leer_Velocidad(Velocidad);  -- Uso correcto de procedimiento
         datos_posalt_vel.Datos_Vuelo.Leer_Altitud(Altitud);      -- Uso correcto de procedimiento
         devicesFSS_V1.Read_Light_Intensity(Visibilidad);
         Piloto_Presente := devicesFSS_V1.Read_PilotPresence;

         -- Leer posiciones del joystick
         devicesFSS_V1.Read_Joystick(Joystick);

         -- Calcular tiempo de colisión
         if Velocidad > 0 then
            Tiempo_Colision := Duration(Float(Distancia) / Float(Velocidad));
         else
            Tiempo_Colision := Tiempo_Alarma; -- Valor alto si la velocidad es 0
         end if;

         -- Evaluación de condiciones para aviso o desvío
         if (Visibilidad < 500 or else Piloto_Presente = 0) then
            if Tiempo_Colision < Tiempo_Desvio_Visibilidad_Baja then
               Desvio_Control.Activate_Desvio;
            elsif Tiempo_Colision < Tiempo_Visibilidad_Baja then
               devicesFSS_V1.Alarm(4);
            end if;
         elsif Tiempo_Colision < Tiempo_Desvio then
            Desvio_Control.Activate_Desvio;
         elsif Tiempo_Colision < Tiempo_Alarma then
            devicesFSS_V1.Alarm(4);
         end if;

         -- Control de tiempo
         Next_Time := Ada.Real_Time.Clock + Milliseconds(250); -- 250 ms como Duration
         delay until Next_Time;
      end loop;
   end Supervisor_Obstaculos;

   -- Implementación de la tarea Desviador_Obstaculos
   task body Desviador_Obstaculos is
      Altitud : devicesFSS_V1.Altitude_Samples_Type;
      Pitch   : devicesFSS_V1.Pitch_Samples_Type;
      Roll    : devicesFSS_V1.Roll_Samples_Type;
      Next_Time : Ada.Real_Time.Time := Ada.Real_Time.Clock;
   begin
      loop
         if Desvio_Control.Is_Desvio_Active then
            -- Leer altitud y los valores de pitch y roll
            datos_posalt_vel.Datos_Vuelo.Leer_Altitud(Altitud);  -- Uso correcto de procedimiento
            datos_posalt_vel.Datos_Vuelo.Leer_Pitch(Pitch);      -- Uso correcto de procedimiento
            datos_posalt_vel.Datos_Vuelo.Leer_Roll(Roll);        -- Uso correcto de procedimiento

            -- Realizar maniobra basada en la altitud
            if Altitud <= 8500 then
               devicesFSS_V1.Set_Aircraft_Pitch(20); -- Incrementar pitch
            else
               devicesFSS_V1.Set_Aircraft_Roll(45); -- Realizar roll
            end if;

            Next_Time := Ada.Real_Time.Clock + Milliseconds(3000); -- 3 segundos como Duration
            delay until Next_Time; 

            -- Estabilizar la nave después de la maniobra
            if Altitud <= 8500 then
               devicesFSS_V1.Set_Aircraft_Pitch(0); -- Estabilizar pitch
            else
               devicesFSS_V1.Set_Aircraft_Roll(0); -- Estabilizar roll
            end if;

            -- Reiniciar el estado del desvío
            Desvio_Control.Reset_Desvio;
         else
            -- Sin desvío pendiente, esperar el siguiente ciclo
            Next_Time := Ada.Real_Time.Clock + Milliseconds(250); -- 250 ms como Duration
            delay until Next_Time;
         end if;
      end loop;
   end Desviador_Obstaculos;

end control_detector_obstaculos;
