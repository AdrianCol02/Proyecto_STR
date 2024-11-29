-- Hecho por: Nicolás Clavo Collado, Adrián Ruiz Serrano y Adrián Colomer Ugrinovic

with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;
with datos_aeronave;
with datos_posalt_vel;

package body control_detector_obstaculos is

   -- Implementación del objeto protegido para control de desvío
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

   -- Implementación de la tarea Control_Obstaculos
   task body Control_Obstaculos is
      Distancia       : devicesFSS_V1.Distance_Samples_Type;
      Velocidad       : devicesFSS_V1.Speed_Samples_Type;
      Altitud         : devicesFSS_V1.Altitude_Samples_Type;
      Visibilidad     : devicesFSS_V1.Light_Samples_Type;
      Piloto_Presente : devicesFSS_V1.PilotPresence_Samples_Type;
      Joystick        : devicesFSS_V1.Joystick_Samples_Type;
      Tiempo_Colision : Duration;
      Pitch           : devicesFSS_V1.Pitch_Samples_Type;
      Roll            : devicesFSS_V1.Roll_Samples_Type;
      Next_Time       : Ada.Real_Time.Time := Ada.Real_Time.Clock;
      Start_Time, End_Time : Time;
      WCET : Duration := 0.0;
   begin
      loop
         Start_Time := Clock;

         -- Leer datos de sensores
         datos_aeronave.aeronave.Leer_Distance(Distancia);
         datos_aeronave.aeronave.Leer_Light_Intensity(Visibilidad);
         datos_aeronave.aeronave.Leer_Velocidad(Velocidad);        
         datos_aeronave.aeronave.Leer_PilotPresence(Piloto_Presente);
         
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

         -- Comprobación de desvío y maniobra
         if Desvio_Control.Is_Desvio_Active then
            -- Leer los valores de pitch y roll
            datos_posalt_vel.Datos_Vuelo.Leer_Altitud(Altitud);
            datos_posalt_vel.Datos_Vuelo.Leer_Pitch(Pitch);
            datos_posalt_vel.Datos_Vuelo.Leer_Roll(Roll);      

            
            if Altitud <= 8500 then
               datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(+20);
            else
               datos_posalt_vel.Datos_Vuelo.Actualizar_Roll(+45);
            end if;

            -- Estabilizar la nave después de la maniobra
            if Altitud > 8500 then
               datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(0);
            else
               datos_posalt_vel.Datos_Vuelo.Actualizar_Roll(0);
            end if;
            -- Reiniciar el estado del desvío
            Desvio_Control.Reset_Desvio;
         end if;
         Display_Distance(Distancia);

         End_Time := Clock;
         WCET := Duration'Max(WCET, To_Duration(End_Time - Start_Time));

         -- Mostrar el WCET
         Put_Line(" ");
         Ada.Text_IO.Put_Line("WCET colision: " & Duration'Image(WCET));

         -- Esperar hasta el próximo ciclo
         delay until Ada.Real_Time.Clock + Milliseconds(250); 
      end loop;
   end Control_Obstaculos;

end control_detector_obstaculos;
