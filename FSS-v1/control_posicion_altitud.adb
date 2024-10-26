with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;
with datos_posatl_vel; 

package body control_posicion_altitud is

    -- Constantes de control de ángulos
    Max_Pitch_Angle : constant Pitch_Samples_Type := 30;
    Min_Pitch_Angle : constant Pitch_Samples_Type := -30;
    Max_Roll_Angle : constant Roll_Samples_Type := 45;
    Min_Roll_Angle : constant Roll_Samples_Type := -45;
    Alert_Roll_Angle : constant Roll_Samples_Type := 35;

    -- Constantes de Altitud
    Min_Altitude : constant Altitude_Samples_Type := 2000;
    Alert_Altitude_Low : constant Altitude_Samples_Type := 2500;
    Max_Altitude : constant Altitude_Samples_Type := 10000;
    Alert_Altitude_High : constant Altitude_Samples_Type := 9500;

    task body control_pitch is
        Joystick : Joystick_Samples_Type;
        Joystick_Pitch : Pitch_Samples_Type;
        Current_Altitude : Altitude_Samples_Type;
        Current_Speed : Speed_Samples_Type;
    begin
        loop
            -- Leer datos del joystick y la altitud
            Read_Joystick(Joystick);
            Joystick_Pitch := Joystick(x);
            Current_Altitude := Read_Altitude;
            Current_Speed := Read_Speed;

            -- Actualizar datos en el objeto protegido `Datos_Vuelo`
            datos_posatl_vel.Datos_Vuelo.Actualizar_Datos(
                Velocidad  => Float(Current_Speed),
                Altitud    => Float(Current_Altitude),
                Posicion_X => Float(Joystick(x)),
                Posicion_Y => Float(Joystick(y))
            );

            -- Control de inclinación del cabeceo basado en la altitud
            if Joystick_Pitch <= Max_Pitch_Angle and Joystick_Pitch >= Min_Pitch_Angle then
                if Current_Altitude <= Min_Altitude then
                    Set_Aircraft_Pitch(0);
                    Put_Line("Altitud crítica, nivelando aeronave");
                elsif Current_Altitude >= Max_Altitude then
                    Set_Aircraft_Pitch(0);
                    Put_Line("Altitud máxima alcanzada, nivelando aeronave");
                elsif (Joystick_Pitch < 0 and Current_Altitude > Min_Altitude) or
                      (Joystick_Pitch > 0 and Current_Altitude < Max_Altitude) then
                    Set_Aircraft_Pitch(Joystick_Pitch);
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
            Current_Altitude := Read_Altitude;
            Current_Speed := Read_Speed;

            -- Actualizar datos en el objeto protegido `Datos_Vuelo`
            datos_posatl_vel.Datos_Vuelo.Actualizar_Datos(
                Velocidad  => Float(Current_Speed),
                Altitud    => Float(Current_Altitude),
                Posicion_X => 0.0, -- No se usa en esta tarea
                Posicion_Y => 0.0  -- No se usa en esta tarea
            );

            -- Control de altitudes críticas
            if Current_Altitude <= Min_Altitude then
                Set_Aircraft_Pitch(0);
                Put_Line("Altitud crítica, nivelando aeronave");
            elsif Current_Altitude >= Max_Altitude then
                Set_Aircraft_Pitch(0);
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
            Joystick_Roll := Joystick(y);
            Current_Altitude := Read_Altitude;
            Current_Speed := Read_Speed;

            -- Actualizar datos en el objeto protegido `Datos_Vuelo`
            datos_posatl_vel.Datos_Vuelo.Actualizar_Datos(
                Velocidad  => Float(Current_Speed),
                Altitud    => Float(Current_Altitude),
                Posicion_X => Float(Joystick(x)),
                Posicion_Y => Float(Joystick(y))
            );

            -- Control de ángulo de alabeo
            if Joystick_Roll <= Max_Roll_Angle and Joystick_Roll >= Min_Roll_Angle then
                Set_Aircraft_Roll(Joystick_Roll);
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
