with devicesFSS_V1; use devicesFSS_V1;
with Ada.Real_Time; use Ada.Real_Time;

package datos_posalt_vel is
    protected Datos_Vuelo is
        -- Procedimientos de actualización
        procedure Actualizar_Velocidad;
        procedure Actualizar_Altitud;
        procedure Actualizar_Posicion_X;
        procedure Actualizar_Posicion_Y;

        -- Procedimientos de lectura
        procedure Leer_Velocidad(Velocidad : out Speed_Samples_Type);
        procedure Leer_Altitud(Altitud : out Altitude_Samples_Type);
        procedure Leer_Posicion_X(Posicion_X : out Joystick_Samples_Values);
        procedure Leer_Posicion_Y(Posicion_Y : out Joystick_Samples_Values);

    private
        -- Variables privadas que almacenan los datos actuales
        Velocidad_Actual : Speed_Samples_Type := 0;  -- velocidad inicial
        Altitud_Actual : Altitude_Samples_Type := 0; -- altitud inicial
        Posicion_X_Actual : Joystick_Samples_Values := 0;  -- posición inicial en X
        Posicion_Y_Actual : Joystick_Samples_Values := 0;  -- posición inicial en Y
    end Datos_Vuelo;
end datos_posalt_vel;
