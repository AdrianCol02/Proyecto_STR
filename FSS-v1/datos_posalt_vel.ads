-- Hecho por: Nicolás Clavo Collado, Adrián Ruiz Serrano y Adrián Colomer Ugrinovic

with devicesFSS_V1; use devicesFSS_V1;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;

package datos_posalt_vel is
    protected Datos_Vuelo is
    
        -- Procedimientos de lectura
        procedure Leer_Velocidad(Velocidad : out Speed_Samples_Type);
        procedure Leer_Altitud(Altitud : out Altitude_Samples_Type);
        procedure Leer_Pitch(Pitch : out Pitch_Samples_Type);
        procedure Leer_Roll(Roll : out Roll_Samples_Type);

        procedure Actualizar_Altitud (Nueva_Altitud : in Altitude_Samples_Type);
        procedure Actualizar_Velocidad (Nueva_Velocidad : in Speed_Samples_Type);
        procedure Actualizar_Pitch (Nuevo_Pitch : in Pitch_Samples_Type);
        procedure Actualizar_Roll (Nuevo_Roll : in Roll_Samples_Type);

    private
        -- Variables privadas que almacenan los datos actuales
        Velocidad_Actual : Speed_Samples_Type := 0;  -- velocidad inicial
        Altitud_Actual : Altitude_Samples_Type := Initial_Altitude; -- altitud inicial
        Pitch_Actual : Pitch_Samples_Type := 0;  -- valor inicial de pitch
        Roll_Actual : Roll_Samples_Type := 0;    -- valor inicial de roll
    end Datos_Vuelo;
end datos_posalt_vel;