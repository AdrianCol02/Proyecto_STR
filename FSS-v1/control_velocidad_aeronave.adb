-- Hecho por: Nicolás Clavo Collado, Adrián Ruiz Serrano y Adrián Colomer Ugrinovic

with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;
with datos_posalt_vel;
with datos_aeronave;
with Ada.Execution_Time; use Ada.Execution_Time;

package body control_velocidad_aeronave is

    task body control_velocidad is
        Potenciometro : Power_Samples_Type;
        Velocidad_Potencia : Float;
        Nueva_Velocidad : Speed_Samples_Type;
        Velocidad_Actual : Speed_Samples_Type;
        Pitch_Actual : Pitch_Samples_Type;
        Roll_Actual : Roll_Samples_Type;
        Start_Time, End_Time : CPU_Time;
        WCET : CPU_Time := To_CPU_Time(0);
    begin
        loop
            Start_Time := Clock;

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

            End_Time := Clock;
            if End_Time - Start_Time > WCET then
                WCET := End_Time - Start_Time;
            end if;

            -- Mostrar el WCET
            Ada.Text_IO.Put_Line("WCET: " & CPU_Time'Image(WCET));
            delay until Clock + Intervalo_Control;
        end loop;
    end control_velocidad;

end control_velocidad_aeronave;
