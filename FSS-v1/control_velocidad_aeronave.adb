with Ada.Real_Time; use Ada.Real_Time;
with devicesFSS_V1; use devicesFSS_V1;
with datos_posalt_vel;

package body control_velocidad_aeronave is

    task body Transferir_Potencia_Piloto is 
        Potenciometro : Power_Samples_Type;
        Velocidad_Potencia : Float;
        Nueva_Velocidad : Speed_Samples_Type;
    begin
        loop
            -- Leer la potencia del potenciometro y calcular la velocidad resultante
            Read_Power(Potenciometro);
            Velocidad_Potencia := Float(Potenciometro) * Factor_Potenciometro;

            -- Convertir y limitar la velocidad calculada al rango permitido
            if Velocidad_Potencia > Float(Max_Velocidad) then
                Nueva_Velocidad := Max_Velocidad;
                Light_2(On);
            elsif Velocidad_Potencia < Float(Min_Velocidad) then
                Nueva_Velocidad := Min_Velocidad;
                Light_2(On);
            else
                Nueva_Velocidad := Speed_Samples_Type(Velocidad_Potencia);
            end if;

            Set_Speed(Nueva_Velocidad);

            delay until Clock + Intervalo_Control;
        end loop;
    end Transferir_Potencia_Piloto;

    task body Control_Velocidad_Cabeceo is
        Velocidad_Actual : Speed_Samples_Type;
        Pitch_Actual : Pitch_Samples_Type;
    begin
        loop
            -- Obtener datos desde el objeto protegido `Datos_Vuelo`
            datos_posalt_vel.Datos_Vuelo.Leer_Velocidad(Velocidad_Actual);
            datos_posalt_vel.Datos_Vuelo.Leer_Pitch(Pitch_Actual);

            if Pitch_Actual > 0 and then Velocidad_Actual < Max_Velocidad then
                Velocidad_Actual := Velocidad_Actual + Incremento_Cabeceo;
                if Velocidad_Actual > Max_Velocidad then
                    Velocidad_Actual := Max_Velocidad;
                    Light_2(On);
                end if;
                Set_Speed(Velocidad_Actual);
            end if;

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Velocidad_Cabeceo;

    task body Control_Velocidad_Alabeo is
        Velocidad_Actual : Speed_Samples_Type;
        Roll_Actual : Roll_Samples_Type;
    begin
        loop
            -- Obtener datos desde el objeto protegido `Datos_Vuelo`
            datos_posalt_vel.Datos_Vuelo.Leer_Velocidad(Velocidad_Actual);
            datos_posalt_vel.Datos_Vuelo.Leer_Roll(Roll_Actual);

            if Roll_Actual > 0 and then Velocidad_Actual < Max_Velocidad then
                Velocidad_Actual := Velocidad_Actual + Incremento_Alabeo;
                if Velocidad_Actual > Max_Velocidad then
                    Velocidad_Actual := Max_Velocidad;
                    Light_2(On);
                end if;
                Set_Speed(Velocidad_Actual);
            end if;

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Velocidad_Alabeo;

    task body Control_Velocidad_CabeceoAlabeo is
        Velocidad_Actual : Speed_Samples_Type;
        Pitch_Actual : Pitch_Samples_Type;
        Roll_Actual : Roll_Samples_Type;
    begin
        loop
            -- Obtener datos desde el objeto protegido `Datos_Vuelo`
            datos_posalt_vel.Datos_Vuelo.Leer_Velocidad(Velocidad_Actual);
            datos_posalt_vel.Datos_Vuelo.Leer_Pitch(Pitch_Actual);
            datos_posalt_vel.Datos_Vuelo.Leer_Roll(Roll_Actual);

            if Pitch_Actual > 0 and then Roll_Actual > 0 and then Velocidad_Actual < Max_Velocidad then
                Velocidad_Actual := Velocidad_Actual + Incremento_CabeceoAlabeo;
                if Velocidad_Actual > Max_Velocidad then
                    Velocidad_Actual := Max_Velocidad;
                    Light_2(On);
                end if;
                Set_Speed(Velocidad_Actual);
            end if;

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Velocidad_CabeceoAlabeo;

    task body Control_Potencia_Motor is
        Velocidad_Actual : Speed_Samples_Type;
    begin
        loop
            -- Obtener datos desde el objeto protegido `Datos_Vuelo`
            datos_posalt_vel.Datos_Vuelo.Leer_Velocidad(Velocidad_Actual);

            -- Avisar si la velocidad está por debajo del mínimo permitido
            if Velocidad_Actual < Min_Velocidad then
                Light_2(On);
                Alarm(3);
            end if;

            -- Ajustar si la velocidad cae por debajo de la velocidad crítica
            if Velocidad_Actual < Velocidad_Critica then
                Alarm(5);
                Set_Speed(Min_Velocidad);
            end if;

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Potencia_Motor;

end control_velocidad_aeronave;
