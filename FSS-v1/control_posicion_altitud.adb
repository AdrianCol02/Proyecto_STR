with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;

package body control_posicion_altitud is

    --Constantes de control de angulos
    Max_Pitch_Angle : constant Integer:= 30;
    Min_Pitch_Angle : constant Integer:= -30;
    Max_Roll_Angle : constant Integer:= 45;
    Min_Roll_Angle : constant Integer:= -45;

    --Constantes de Altitud
    Min_Altitude : constant Natural:= 2000;
    Alert_Altitude_Low : constant Natural:= 2500;
    Max_Altitude : constant Natural:= 10000;
    Alert_Altitude_High : constant Natural:= 9500;

    task body control_pitch is
        Joystick_pitch : Pitch_Samples_Type := Read_Joystick(x);
    begin
        loop
            accept Set_Aircraft_Pitch(pitch: in Joystick_pitch) do
                if Joystick_pitch <= Max_Pitch_Angle and Joystick_pitch >= Min_Pitch_Angle then
                    Set_Aircraft_Pitch(Joystick_pitch);
                end if;
            end Set_Aircraft_Pitch;
        end loop;

    end control_pitch;

    task body control_altitude is
        Current_Altitude : Altitude_Samples_Type := Read_Altitude; --Se declara de esta forma previo a la implementacion del objeto protegido
    begin
        loop
            --Seccion que controla las altitudes criticas
            if Current_Altitude <= Min_Altitude then
                Set_Aircraft_Pitch(0);
                Put_Line("Altitud critica, nivelando aeronave");
            elsif Current_Altitude > Max_Altitude then
                Set_Aircraft_Pitch(0);
                Put_Line("Altitud demasiado elevada, nivelando aeronave");
            end if;

            --Seccion que controla las alertas de altitud
            if Current_Altitude < Alert_Altitude_Low then
                Light_1(ON);
            elsif Current_Altitude > Alert_Altitude_High then
                Light_1(ON);
            end if;
        end loop;
        
    end control_altitude;

    task body control_roll is --TODO
        Joystick_roll : Roll_Samples_Type := Read_Joystick(y);
    begin
    end control_roll;

end control_posicion_altitud;