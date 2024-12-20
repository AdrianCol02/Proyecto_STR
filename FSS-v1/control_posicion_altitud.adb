-- Hecho por: Nicolás Clavo Collado, Adrián Ruiz Serrano y Adrián Colomer Ugrinovic

with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;
with datos_posalt_vel; use datos_posalt_vel;

package body control_posicion_altitud is
   
   task body posicion_altitud is
      Joystick : Joystick_Samples_Type;
      Joystick_Pitch : Pitch_Samples_Type;
      Joystick_Roll : Roll_Samples_Type;
      Current_Altitude : Altitude_Samples_Type;
      Current_Speed : Speed_Samples_Type;
      Start_Time, End_Time : Time;
      WCET : Duration := 0.0;
   begin
      loop
         Start_Time := Clock;

         -- Leer datos del joystick y la altitud
         Read_Joystick(Joystick);
         Joystick_Pitch := Pitch_Samples_Type(Joystick(x));
         Joystick_Roll := Roll_Samples_Type(Joystick(y));
         datos_posalt_vel.Datos_Vuelo.Leer_Altitud(Current_Altitude);
         datos_posalt_vel.Datos_Vuelo.Leer_Velocidad(Current_Speed);

         -- Control de inclinación del cabeceo basado en la altitud
         if Joystick_Pitch <= Max_Pitch_Angle and Joystick_Pitch >= Min_Pitch_Angle then
            if Current_Altitude <= Min_Altitude then
               datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(+10);
               Put_Line("Altitud crítica, nivelando aeronave");
            elsif Current_Altitude >= Max_Altitude then
               datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(-10);
               Put_Line("Altitud máxima alcanzada, nivelando aeronave");
            elsif (Joystick_Pitch < 0 and Current_Altitude > Min_Altitude) or
                  (Joystick_Pitch > 0 and Current_Altitude < Max_Altitude) then
               datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(0);
            else
               datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(Joystick_Pitch);
            end if;
         end if;
         -- Alertas de altitud
         if Current_Altitude < Alert_Altitude_Low or Current_Altitude > Alert_Altitude_High then
            Light_1(On);
         else
            Light_1(Off);
         end if;

         
         -- Control de ángulo de alabeo
         if Joystick_Roll <= Max_Roll_Angle and Joystick_Roll >= Min_Roll_Angle then
            datos_posalt_vel.Datos_Vuelo.Actualizar_Roll(Joystick_Roll);
            if Joystick_Roll >= Alert_Roll_Angle or Joystick_Roll <= -Alert_Roll_Angle then
               Light_2(On);
            else
               Light_2(Off);
            end if;
         end if;
         Display_Altitude(Current_Altitude);

         End_Time := Clock;
         WCET := Duration'Max(WCET, To_Duration(End_Time - Start_Time));

         -- Mostrar el WCET
         Put_Line(" ");
         Ada.Text_IO.Put_Line("WCET posalt: " & Duration'Image(WCET));

         -- Esperar hasta el próximo ciclo
         delay until Ada.Real_Time.Clock + Milliseconds(200);
      end loop;
   end posicion_altitud;

end control_posicion_altitud;
