with devicesFSS_V1; use devicesFSS_V1;
with Ada.Real_Time; use Ada.Real_Time;
package body datos_posalt_vel is
    protected body Datos_Vuelo is

        procedure Actualizar_Velocidad is
        begin
            -- Leer la velocidad usando `devicesFSS_V1`
            Velocidad_Actual := Read_Speed;
        end Actualizar_Velocidad;

        procedure Actualizar_Altitud is
        begin
            -- Leer la altitud usando `devicesFSS_V1`
            Altitud_Actual := Read_Altitude;
        end Actualizar_Altitud;

        procedure Actualizar_Pitch is
        begin
            -- Leer el pitch usando `devicesFSS_V1`
            Pitch_Actual := Read_Pitch;
        end Actualizar_Pitch;

        procedure Actualizar_Roll is
        begin
            -- Leer el roll usando `devicesFSS_V1`
            Roll_Actual := Read_Roll;
        end Actualizar_Roll;

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

    end Datos_Vuelo;
end datos_posalt_vel;

