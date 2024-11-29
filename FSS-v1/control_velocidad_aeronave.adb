-- Hecho por: Nicolás Clavo Collado, Adrián Ruiz Serrano y Adrián Colomer Ugrinovic

with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;
with datos_posalt_vel;
with datos_aeronave;

package body control_velocidad_aeronave is

    task body control_velocidad is
        Potenciometro : Power_Samples_Type;
        Velocidad_Potencia : Float;
        Nueva_Velocidad : Speed_Samples_Type;
        Velocidad_Actual : Speed_Samples_Type;
        Pitch_Actual, Pitch_Anterior : Pitch_Samples_Type;
        Roll_Actual, Roll_Anterior : Roll_Samples_Type;
        Start_Time, End_Time : Time;
        WCET : Duration := 0.0;
    begin
        loop
            Start_Time := Clock;

            -- Primero, leer la potencia del potenciometro y actualizar la velocidad
            Read_Power(Potenciometro);
            datos_aeronave.aeronave.Actualizar_Potencia(Potenciometro);
            Velocidad_Potencia := Float(Potenciometro) * Factor_Potenciometro;

            -- Limitar la velocidad calculada al rango permitido
            if Velocidad_Potencia > Float(Max_Velocidad) then
                Nueva_Velocidad := Max_Velocidad;
                Light_2(On);
            elsif Velocidad_Potencia < Float(Min_Velocidad) then
                Nueva_Velocidad := Min_Velocidad;
                Light_2(On);
            else
                Nueva_Velocidad := Speed_Samples_Type(Velocidad_Potencia);
            end if;

            -- Actualizar la velocidad de la aeronave
            datos_posalt_vel.Datos_Vuelo.Actualizar_Velocidad(Nueva_Velocidad);

            -- Leer datos del sistema de vuelo: velocidad, pitch y roll
            datos_posalt_vel.Datos_Vuelo.Leer_Velocidad(Velocidad_Actual);
            datos_posalt_vel.Datos_Vuelo.Leer_Pitch(Pitch_Actual);
            datos_posalt_vel.Datos_Vuelo.Leer_Roll(Roll_Actual);

            -- Comprobar maniobras de alabeo, cabeceo o ambas
            if Pitch_Actual /= Pitch_Anterior and Roll_Actual /= Roll_Anterior then
                -- Maniobra de cabeceo y alabeo simultáneo
                if Velocidad_Actual < Max_Velocidad then
                    Nueva_Velocidad := Velocidad_Actual + 250;
                    if Nueva_Velocidad > Max_Velocidad then
                        Nueva_Velocidad := Max_Velocidad;
                    end if;
                    datos_posalt_vel.Datos_Vuelo.Actualizar_Velocidad(Nueva_Velocidad);
                end if;
            elsif Pitch_Actual /= Pitch_Anterior then
                -- Maniobra de cabeceo
                if Velocidad_Actual < Max_Velocidad then
                    Nueva_Velocidad := Velocidad_Actual + 150;
                    if Nueva_Velocidad > Max_Velocidad then
                        Nueva_Velocidad := Max_Velocidad;
                    end if;
                    datos_posalt_vel.Datos_Vuelo.Actualizar_Velocidad(Nueva_Velocidad);
                end if;
            elsif Roll_Actual /= Roll_Anterior then
                -- Maniobra de alabeo
                if Velocidad_Actual < Max_Velocidad then
                    Nueva_Velocidad := Velocidad_Actual + 100;
                    if Nueva_Velocidad > Max_Velocidad then
                        Nueva_Velocidad := Max_Velocidad;
                    end if;
                    datos_posalt_vel.Datos_Vuelo.Actualizar_Velocidad(Nueva_Velocidad);
                end if;
            end if;

            -- Alerta si la potencia del motor está por debajo de los 300 Km/h
            if Velocidad_Actual < 300 then
                Light_2(On);
            end if;

            -- Aumentar empuje si la velocidad se reduce por debajo de los 250 km/h
            if Velocidad_Actual < 250 then
                Nueva_Velocidad := 300;
                datos_posalt_vel.Datos_Vuelo.Actualizar_Velocidad(Nueva_Velocidad);
            end if;

            -- Guardar los valores actuales de Pitch y Roll para la próxima iteración
            Pitch_Anterior := Pitch_Actual;
            Roll_Anterior := Roll_Actual;

            -- Regular la velocidad del avión cada 300 milisegundos
            delay 0.3;

            End_Time := Clock;
            WCET := Duration'Max(WCET, To_Duration(End_Time - Start_Time));
        end loop;
    end control_velocidad;
end control_velocidad_aeronave;
