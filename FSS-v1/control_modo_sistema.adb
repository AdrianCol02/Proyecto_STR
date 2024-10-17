with Ada.Real_Time; Use Ada.Real_Time;
with devicesFSS_V1; Use devicesFSS_V1;

package body control_modo_sistema is

    Modo_Actual : Modo_Sistema := Modo_Inicial;

    Intervalo_Control : constant Time_Span := Milliseconds(200);

task body Control_Modo is
begin
    loop
        if Read_PilotButton = 1 then
            if Modo_Actual = Automatico then
                Modo_Actual := Manual;
                Put_Line("Modo de control cambiado a manual");
            else
                Modo_Actual := Automatico;
                Put_Line("Modo de control cambiado a automático");
            end if;
        end if;

        delay until Clock + Intervalo_Control;
    end loop;
end Control_Modo;

task body Control_Avisos_Alarmas is
    Velocidad_Actual : Speed_Samples_Type;
    Altitud_Actual : Altitude_Samples_Type;
begin
    loop
        Velocidad_Actual := Read_Speed;
        Altitud_Actual := Read_Altitude;

        if Velocidad_Actual < Min_Velocidad then
            Light_2(On);
            Alarm(3);
        elsif Altitud_Actual < Min_Altitude then
            Light_1(On);
            Display_Message("Altitud baja, ascienda");
        elsif Altitud_Actual > Max_Altitude then
            Light_1(On);
            Display_Message("Altitud alta, descienda");
        else
            Light_1(Off);
            Light_2(Off);
        end if;
        delay until Clock + Intervalo_Control;
    end loop;
end Control_Avisos_Alarmas;

task body Control_Maniobras_Automaticas is
    Velocidad_Actual : Speed_Samples_Type;
    Altitud_Actual : Altitude_Samples_Type;
    Pitch_Actual : Pitch_Samples_Type;
begin
    loop
        -- Funciona únicamente en caso de que esté activado el modo automático
        if Modo_Actual = Automatico then
            Velocidad_Actual := Read_Speed;
            Altitud_Actual := Read_Altitude;
            Pitch_Actual := Read_Pitch;

            -- Control de altitud
            if Altitud_Actual <= Min_Altitude then
                Set_Aircraft_Pitch(0);
                Display_Message("Altitud baja, nivelando aeronave");
            elsif Altitud_Actual >= Max_Altitude then
                Set_Aircraft_Pitch(0);
                Display_Message("Altitud alta, nivelando aeronave");
            end if;

            -- Control de velocidad
            if Velocidad_Actual < Min_Velocidad then
                Set_Speed(Min_Velocidad);
                Display_Message("Velocidad baja, aumentando hasta los 300 km/h");
            end if;
        end if;
    end loop;
end Control_Maniobras_Automaticas;

end control_modo_sistema;
