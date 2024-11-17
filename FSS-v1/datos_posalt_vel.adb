with devicesFSS_V1; use devicesFSS_V1;
with Ada.Real_Time; use Ada.Real_Time;
package body datos_posalt_vel is
    protected body Datos_Vuelo is
        -- Procedimientos de lectura actualizados
        procedure Leer_Velocidad(Velocidad : out Speed_Samples_Type) is
        begin
            -- Asignar el valor actual de la velocidad al parámetro `out`
            Velocidad := Velocidad_Actual;
        end Leer_Velocidad;

        procedure Leer_Altitud(Altitud : out Altitude_Samples_Type) is
        begin
            -- Asignar el valor actual de la altitud al parámetro `out`
            Altitud := Altitud_Actual;
        end Leer_Altitud;

        procedure Leer_Pitch(Pitch : out Pitch_Samples_Type) is
        begin
            -- Asignar el valor actual del pitch al parámetro `out`
            Pitch := Pitch_Actual;
        end Leer_Pitch;

        procedure Leer_Roll(Roll : out Roll_Samples_Type) is
        begin
            -- Asignar el valor actual del roll al parámetro `out`
            Roll := Roll_Actual;
        end Leer_Roll;

        -- Procedimientos de actualización datos
        procedure Actualizar_Altitud (Nueva_Altitud : in Altitude_Samples_Type) is
        begin
            -- Asignar el valor de la nueva altitud a la variable privada
            Altitud_Actual := Nueva_Altitud;
        end Actualizar_Altitud;

        procedure Actualizar_Velocidad (Nueva_Velocidad : in Speed_Samples_Type) is
        begin
            -- Asignar el valor de la nueva velocidad a la variable privada
            Velocidad_Actual := Nueva_Velocidad;
        end Actualizar_Velocidad;

        procedure Actualizar_Pitch (Nuevo_Pitch : in Pitch_Samples_Type) is
        begin
            -- Asignar el valor del nuevo pitch a la variable privada
            Pitch_Actual := Nuevo_Pitch;
        end Actualizar_Pitch;

        procedure Actualizar_Roll (Nuevo_Roll : in Roll_Samples_Type) is
        begin
            -- Asignar el valor del nuevo roll a la variable privada
            Roll_Actual := Nuevo_Roll;
        end Actualizar_Roll;

    end Datos_Vuelo;
end datos_posalt_vel;

