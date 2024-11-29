-- Hecho por: Nicolás Clavo Collado, Adrián Ruiz Serrano y Adrián Colomer Ugrinovic

with devicesFSS_V1; use devicesFSS_V1;
with Ada.Real_Time; use Ada.Real_Time;
with tools; use tools;

package body datos_posalt_vel is
    protected body Datos_Vuelo is

        -- Procedimientos de lectura actualizados
        procedure Leer_Velocidad(Velocidad : out Speed_Samples_Type) is
        begin
            -- Asignar el valor actual de la velocidad al parámetro `out`
            Execution_Time(Milliseconds(2));
            Velocidad := devicesFSS_V1.Read_Speed;
            Datos_Vuelo.Velocidad_Actual := Velocidad;
        end Leer_Velocidad;

        procedure Leer_Altitud(Altitud : out Altitude_Samples_Type) is
        begin
            -- Asignar el valor actual de la altitud al parámetro `out`
            Execution_Time(Milliseconds(2));
            Altitud := devicesFSS_V1.Read_Altitude;
            Datos_Vuelo.Altitud_Actual := Altitud;
        end Leer_Altitud;

        procedure Leer_Pitch(Pitch : out Pitch_Samples_Type) is
        begin
            -- Asignar el valor actual del pitch al parámetro `out`
            Execution_Time(Milliseconds(2));
            Pitch := devicesFSS_V1.Read_Pitch;
            Datos_Vuelo.Pitch_Actual := Pitch;
        end Leer_Pitch;

        procedure Leer_Roll(Roll : out Roll_Samples_Type) is
        begin
            -- Asignar el valor actual del roll al parámetro `out`
            Execution_Time(Milliseconds(2));
            Roll := devicesFSS_V1.Read_Roll;
            Datos_Vuelo.Roll_Actual := Roll;
        end Leer_Roll;

        -- Procedimientos de actualización datos
        procedure Actualizar_Velocidad (Nueva_Velocidad : in Speed_Samples_Type) is
        begin
            -- Asignar el valor de la nueva velocidad a la variable privada
            Execution_Time(Milliseconds(5));
            devicesFSS_V1.Set_Speed(Nueva_Velocidad);
            Velocidad_Actual := Nueva_Velocidad;
        end Actualizar_Velocidad;

        procedure Actualizar_Pitch (Nuevo_Pitch : in Pitch_Samples_Type) is
        begin
            -- Asignar el valor del nuevo pitch a la variable privada
            Execution_Time(Milliseconds(5));
            devicesFSS_V1.Set_Aircraft_Pitch(Nuevo_Pitch);
            Pitch_Actual := Nuevo_Pitch;
        end Actualizar_Pitch;

        procedure Actualizar_Roll (Nuevo_Roll : in Roll_Samples_Type) is
        begin
            -- Asignar el valor del nuevo roll a la variable privada
            Execution_Time(Milliseconds(5));
            devicesFSS_V1.Set_Aircraft_Roll(Nuevo_Roll);
            Roll_Actual := Nuevo_Roll;
        end Actualizar_Roll;

    end Datos_Vuelo;
end datos_posalt_vel;

