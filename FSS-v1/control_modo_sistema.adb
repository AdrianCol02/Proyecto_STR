with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;
with Datos_Aeronave; -- Incluir el objeto protegido

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
        Datos : Datos_Aeronave.Datos_Type;
    begin
        loop
            Datos_Aeronave.Leer_Datos(Datos); -- Leer datos del objeto protegido
            Velocidad_Actual := Datos.Velocidad;
            Altitud_Actual := Datos.Altitud;

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
        Datos : Datos_Aeronave.Datos_Type;
    begin
        loop
            if Modo_Actual = Automatico then
                Datos_Aeronave.Leer_Datos(Datos); -- Leer datos del objeto protegido
                Velocidad_Actual := Datos.Velocidad;
                Altitud_Actual := Datos.Altitud;
                Pitch_Actual := Read_Pitch; -- Asumiendo que Read_Pitch es un método existente

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

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Maniobras_Automaticas;

end control_modo_sistema;
