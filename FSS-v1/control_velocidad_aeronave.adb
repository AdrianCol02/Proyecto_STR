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
        Pitch_Actual : Pitch_Samples_Type;
        Roll_Actual : Roll_Samples_Type;
    begin
        loop
           
           Display_Speed(Velocidad_Actual);
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

            Set_Speed(Nueva_Velocidad);
            datos_posalt_vel.Datos_Vuelo.Actualizar_Velocidad(Nueva_Velocidad);
            datos_aeronave.aeronave.Actualizar_Velocidad(Nueva_Velocidad);

            -- Leer datos del sistema de vuelo: velocidad, pitch y roll
            datos_posalt_vel.Datos_Vuelo.Leer_Velocidad(Velocidad_Actual);
            datos_posalt_vel.Datos_Vuelo.Leer_Pitch(Pitch_Actual);
            datos_posalt_vel.Datos_Vuelo.Leer_Roll(Roll_Actual);

            -- Control de velocidad por Cabeceo (Pitch)
            if Pitch_Actual > 0 and then Velocidad_Actual < Max_Velocidad then
                Velocidad_Actual := Velocidad_Actual + Incremento_Cabeceo;
                if Velocidad_Actual > Max_Velocidad then
                    Velocidad_Actual := Max_Velocidad;
                    Light_2(On);
                end if;
                Set_Speed(Velocidad_Actual);
                datos_aeronave.aeronave.Actualizar_Velocidad(Velocidad_Actual);
                datos_posalt_vel.Datos_Vuelo.Actualizar_Velocidad(Velocidad_Actual);
            end if;

            -- Control de velocidad por Alabeo (Roll)
            if Roll_Actual > 0 and then Velocidad_Actual < Max_Velocidad then
                Velocidad_Actual := Velocidad_Actual + Incremento_Alabeo;
                if Velocidad_Actual > Max_Velocidad then
                    Velocidad_Actual := Max_Velocidad;
                    Light_2(On);
                end if;
                Set_Speed(Velocidad_Actual);
                datos_aeronave.aeronave.Actualizar_Velocidad(Velocidad_Actual);
                datos_posalt_vel.Datos_Vuelo.Actualizar_Velocidad(Velocidad_Actual);
            end if;

            -- Control de velocidad por Cabeceo y Alabeo combinados
            if Pitch_Actual > 0 and then Roll_Actual > 0 and then Velocidad_Actual < Max_Velocidad then
                Velocidad_Actual := Velocidad_Actual + Incremento_CabeceoAlabeo;
                if Velocidad_Actual > Max_Velocidad then
                    Velocidad_Actual := Max_Velocidad;
                    Light_2(On);
                end if;
                Set_Speed(Velocidad_Actual);
                datos_aeronave.aeronave.Actualizar_Velocidad(Velocidad_Actual);
                datos_posalt_vel.Datos_Vuelo.Actualizar_Velocidad(Velocidad_Actual);
            end if;

            -- Control de potencia del motor y alarmas si la velocidad es baja
            if Velocidad_Actual < Min_Velocidad then
                Light_2(On);
                Alarm(3);
            end if;

            -- Ajuste de velocidad en caso de alcanzar la velocidad crítica
            if Velocidad_Actual < Velocidad_Critica then
                Alarm(5);
                Set_Speed(Min_Velocidad);
                datos_aeronave.aeronave.Actualizar_Velocidad(Min_Velocidad);
                datos_posalt_vel.Datos_Vuelo.Actualizar_Velocidad(Min_Velocidad);
            end if;
            Display_Speed(Velocidad_Actual);

            -- Espera hasta la siguiente iteración
            delay until Clock + Intervalo_Control;
        end loop;
    end control_velocidad;

end control_velocidad_aeronave;
