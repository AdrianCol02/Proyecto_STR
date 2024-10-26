package body datos_posatl_vel is
    protected body Datos_Vuelo is

        procedure Actualizar_Datos is
            Joystick_Posicion : Joystick_Samples_Type;
        begin
            -- Leer la velocidad y altitud usando `devicesFSS_V1`
            Velocidad_Actual := Read_Speed;
            Altitud_Actual := Read_Altitude;
            
            -- Leer la posición del joystick
            Read_Joystick(Joystick_Posicion);
            Posicion_X_Actual := Joystick_Posicion(x);
            Posicion_Y_Actual := Joystick_Posicion(y);

            -- Actualizar visualización
            Display_Speed(Velocidad_Actual);
            Display_Altitude(Altitud_Actual);
            Display_Joystick(Joystick_Posicion);
        end Actualizar_Datos;

        procedure Leer_Datos(Velocidad : out Speed_Samples_Type; 
                             Altitud : out Altitude_Samples_Type; 
                             Posicion_X : out Joystick_Samples_Values; 
                             Posicion_Y : out Joystick_Samples_Values) is
        begin
            -- Proporcionar los datos actuales
            Velocidad := Velocidad_Actual;
            Altitud := Altitud_Actual;
            Posicion_X := Posicion_X_Actual;
            Posicion_Y := Posicion_Y_Actual;
        end Leer_Datos;

    end Datos_Vuelo;
end datos_posatl_vel;
