with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;
with Datos_Aeronave; -- Incluir el objeto protegido

package body control_posicion_altitud is

    --Constantes de control de angulos
    Max_Pitch_Angle : constant Pitch_Samples_Type:= 30;
    Min_Pitch_Angle : constant Pitch_Samples_Type:= -30;
    Max_Roll_Angle : constant Roll_Samples_Type:= 45;
    Min_Roll_Angle : constant Roll_Samples_Type:= -45;
    Alert_Roll_Angle : constant Roll_Samples_Type:= 35;

    --Constantes de Altitud
    Min_Altitude : constant Altitude_Samples_Type:= 2000;
    Alert_Altitude_Low : constant Altitude_Samples_Type:= 2500;
    Max_Altitude : constant Altitude_Samples_Type:= 10000;
    Alert_Altitude_High : constant Altitude_Samples_Type:= 9500;

    task body control_pitch is
        Joystick : Joystick_Samples_Type;
        Joystick_Pitch : Pitch_Samples_Type;
        Current_Altitude : Altitude_Samples_Type;
        Datos : Datos_Aeronave.Datos_Type;
    begin
        loop
            Read_Joystick(Joystick);
            Joystick_Pitch := Joystick(x);
            Current_Altitude := Read_Altitude;

            -- Actualizar datos en el objeto protegido
            Datos.Altitud := Current_Altitude;
            Datos.Joystick_X := Joystick(x);
            Datos.Joystick_Y := Joystick(y);
            Datos_Aeronave.Actualizar_Datos(Datos); -- Actualizar objeto protegido

            -- Verificamos que el ángulo del joystick esté en el rango permitido
            if Joystick_Pitch <= Max_Pitch_Angle and Joystick_Pitch >= Min_Pitch_Angle then
                -- Control de altitud
                if Current_Altitude <= Min_Altitude then
                    Set_Aircraft_Pitch(0);
                    Put_Line("Altitud crítica, nivelando aeronave");
                elsif Current_Altitude >= Max_Altitude then
                    Set_Aircraft_Pitch(0);
                    Put_Line("Altitud máxima alcanzada, nivelando aeronave");
                elsif (Joystick_Pitch < 0 and Current_Altitude > Min_Altitude) or
                      (Joystick_Pitch > 0 and Current_Altitude < Max_Altitude) then
                    -- Aplicar el ángulo del joystick solo si está permitido por la altitud
                    Set_Aircraft_Pitch(Joystick_Pitch);
                end if;
            end if;

            -- Alertas de altitud
            if Current_Altitude < Alert_Altitude_Low then
                Light_1(On);
            elsif Current_Altitude > Alert_Altitude_High then
                Light_1(On);
            else
                Light_1(Off); -- Apagar la luz si la altitud está en el rango seguro
            end if;

            delay until Clock + Milliseconds(200); -- Intervalo de control para 5 veces por segundo
        end loop;
    end control_pitch;

    task body control_altitude is
        Current_Altitude : Altitude_Samples_Type;
        Datos : Datos_Aeronave.Datos_Type;
    begin
        loop
            Current_Altitude := Read_Altitude;

            -- Actualizar datos en el objeto protegido
            Datos.Altitud := Current_Altitude;
            Datos_Aeronave.Actualizar_Datos(Datos); -- Actualizar objeto protegido

            -- Sección que controla las altitudes críticas
            if Current_Altitude <= Min_Altitude then
                Set_Aircraft_Pitch(0);
                Put_Line("Altitud crítica, nivelando aeronave");
            elsif Current_Altitude >= Max_Altitude then
                Set_Aircraft_Pitch(0);
                Put_Line("Altitud máxima alcanzada, nivelando aeronave");
            end if;

            delay until Clock + Milliseconds(200); -- Intervalo de control para 5 veces por segundo
        end loop;
    end control_altitude;

    task body control_roll is
        Joystick : Joystick_Samples_Type;
        Joystick_Roll : Roll_Samples_Type;
        Datos : Datos_Aeronave.Datos_Type;
    begin
        loop
            Read_Joystick(Joystick);
            Joystick_Roll := Joystick(y);

            -- Actualizar datos en el objeto protegido
            Datos.Joystick_X := Joystick(x);
            Datos.Joystick_Y := Joystick(y);
            Datos_Aeronave.Actualizar_Datos(Datos); -- Actualizar objeto protegido

            -- Verificamos que el ángulo del joystick esté en el rango permitido
            if Joystick_Roll <= Max_Roll_Angle and Joystick_Roll >= Min_Roll_Angle then
                -- Aplicar el ángulo del joystick
                Set_Aircraft_Roll(Joystick_Roll);

                -- Verificar si el ángulo de rol está en el rango crítico
                if Joystick_Roll >= Alert_Roll_Angle or Joystick_Roll <= -Alert_Roll_Angle then
                    Light_2(On); -- Enciende una luz de advertencia
                else
                    Light_2(Off); -- Apagar la luz si el ángulo de rol está seguro
                end if;
            end if;

            delay until Clock + Milliseconds(200); -- Intervalo de control para 5 veces por segundo
        end loop;
    end control_roll;

end control_posicion_altitud;
