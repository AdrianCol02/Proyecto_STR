with devicesFSS_V1; use devicesFSS_V1;
with Ada.Real_Time; use Ada.Real_Time;

package datos_posatl_vel is
    protected Datos_Vuelo is
        procedure Actualizar_Datos;
        procedure Leer_Datos(Velocidad : out Speed_Samples_Type; 
                             Altitud : out Altitude_Samples_Type; 
                             Posicion_X : out Joystick_Samples_Values; 
                             Posicion_Y : out Joystick_Samples_Values);
    private
        Velocidad_Actual : Speed_Samples_Type := Initial_Altitude;  -- velocidad inicial
        Altitud_Actual : Altitude_Samples_Type := Initial_Altitude; -- altitud inicial
        Posicion_X_Actual : Joystick_Samples_Values := 0;           -- posición inicial en X
        Posicion_Y_Actual : Joystick_Samples_Values := 0;           -- posición inicial en Y
    end Datos_Vuelo;
end datos_posatl_vel;
