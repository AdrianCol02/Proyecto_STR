with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;
with datos_posalt_vel; use datos_posalt_vel;
with datos_aeronave; use datos_aeronave;

package body control_posicion_altitud is
   
       task body control_pitch is
        Joystick : Joystick_Samples_Type;
        Joystick_Pitch : Pitch_Samples_Type;
        Current_Altitude : Altitude_Samples_Type;
        Current_Speed : Speed_Samples_Type;
    begin
        loop
            -- Leer datos del joystick y la altitud
            Read_Joystick(Joystick);
            Joystick_Pitch := Pitch_Samples_Type(Joystick(x));
            datos_aeronave.aeronave.Leer_Altitud(Current_Altitude);
            datos_aeronave.aeronave.Leer_Velocidad(Current_Speed);
            datos_aeronave.aeronave.Actualizar_Pitch(Joystick_Pitch);
            datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(Joystick_Pitch);

            -- Control de inclinación del cabeceo basado en la altitud
            if Joystick_Pitch <= Max_Pitch_Angle and Joystick_Pitch >= Min_Pitch_Angle then
                if Current_Altitude <= Min_Altitude then
                    Set_Aircraft_Pitch(0);
                    datos_aeronave.aeronave.Actualizar_Pitch(0);
                    datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(0);
                    Put_Line("Altitud crítica, nivelando aeronave");
                elsif Current_Altitude >= Max_Altitude then
                    Set_Aircraft_Pitch(0);
                    datos_aeronave.aeronave.Actualizar_Pitch(0);
                    datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(0);
                    Put_Line("Altitud máxima alcanzada, nivelando aeronave");
                elsif (Joystick_Pitch < 0 and Current_Altitude > Min_Altitude) or
                      (Joystick_Pitch > 0 and Current_Altitude < Max_Altitude) then
                    Set_Aircraft_Pitch(Joystick_Pitch);
                    datos_aeronave.aeronave.Actualizar_Pitch(Joystick_Pitch);
                    datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(Joystick_Pitch);
                end if;
            end if;

            -- Alertas de altitud
            if Current_Altitude < Alert_Altitude_Low or Current_Altitude > Alert_Altitude_High then
                Light_1(On);
            else
                Light_1(Off);
            end if;

            delay until Clock + Milliseconds(200); -- Control cada 200 ms
        end loop;
    end control_pitch;

    task body control_altitude is
        Current_Altitude : Altitude_Samples_Type;
        Current_Speed : Speed_Samples_Type;
    begin
        loop
            -- Leer altitud y velocidad actuales
            datos_aeronave.aeronave.Leer_Altitud(Current_Altitude);
            datos_aeronave.aeronave.Leer_Velocidad(Current_Speed);

            -- Control de altitudes críticas
            if Current_Altitude <= Min_Altitude then
                Set_Aircraft_Pitch(0);
                datos_aeronave.aeronave.Actualizar_Pitch(0);
                datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(0);
                Put_Line("Altitud crítica, nivelando aeronave");
            elsif Current_Altitude >= Max_Altitude then
                Set_Aircraft_Pitch(0);
                datos_aeronave.aeronave.Actualizar_Pitch(0);
                datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(0);
                Put_Line("Altitud máxima alcanzada, nivelando aeronave");
            end if;

            delay until Clock + Milliseconds(200); -- Control cada 200 ms
        end loop;
    end control_altitude;

    task body control_roll is
        Joystick : Joystick_Samples_Type;
        Joystick_Roll : Roll_Samples_Type;
        Current_Altitude : Altitude_Samples_Type;
        Current_Speed : Speed_Samples_Type;
    begin
        loop
            -- Leer el joystick y otros datos
            Read_Joystick(Joystick);
            Joystick_Roll := Roll_Samples_Type(Joystick(y));
            datos_aeronave.aeronave.Leer_Altitud(Current_Altitude);
            datos_aeronave.aeronave.Leer_Velocidad(Current_Speed);
            datos_aeronave.aeronave.Actualizar_Roll(Joystick_Roll);
            datos_posalt_vel.Datos_Vuelo.Actualizar_Roll(Joystick_Roll);

            -- Control de ángulo de alabeo
            if Joystick_Roll <= Max_Roll_Angle and Joystick_Roll >= Min_Roll_Angle then
                Set_Aircraft_Roll(Joystick_Roll);
                datos_aeronave.aeronave.Actualizar_Roll(Joystick_Roll);
                datos_posalt_vel.Datos_Vuelo.Actualizar_Roll(Joystick_Roll);
                if Joystick_Roll >= Alert_Roll_Angle or Joystick_Roll <= -Alert_Roll_Angle then
                    Light_2(On);
                else
                    Light_2(Off);
                end if;
            end if;

            delay until Clock + Milliseconds(200); -- Control cada 200 ms
        end loop;
    end control_roll;

end control_posicion_altitud;
