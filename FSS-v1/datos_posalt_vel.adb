package body datos_posalt_vel is
    protected body Datos_Vuelo is

        procedure Actualizar_Velocidad is
        begin
            -- Leer la velocidad usando `devicesFSS_V1`
            Velocidad_Actual := Read_Speed;
            Set_Speed(Velocidad_Actual);
            -- Actualizar visualización
            Display_Speed(Velocidad_Actual);
        end Actualizar_Velocidad;

        procedure Actualizar_Altitud is
        begin
            -- Leer la altitud usando `devicesFSS_V1`
            Altitud_Actual := Read_Altitude;
            -- Actualizar visualización
            Display_Altitude(Altitud_Actual);
        end Actualizar_Altitud;

        procedure Actualizar_Posicion_X is
            Joystick_Posicion : Joystick_Samples_Type;
        begin
            -- Leer la posición del joystick
            Read_Joystick(Joystick_Posicion);
            Posicion_X_Actual := Joystick_Posicion(x);
            -- Actualizar visualización
            Display_Joystick(Joystick_Posicion);
        end Actualizar_Posicion_X;

        procedure Actualizar_Posicion_Y is
            Joystick_Posicion : Joystick_Samples_Type;
        begin
            -- Leer la posición del joystick
            Read_Joystick(Joystick_Posicion);
            Posicion_Y_Actual := Joystick_Posicion(y);
            -- Actualizar visualización
            Display_Joystick(Joystick_Posicion);
        end Actualizar_Posicion_Y;

        -- Procedimientos para leer los datos de cada variable

        procedure Leer_Velocidad(Velocidad : out Speed_Samples_Type) is
        begin
            -- Proporcionar el valor actual de la velocidad
            Velocidad := Read_Speed;
        end Leer_Velocidad;

        procedure Leer_Altitud(Altitud : out Altitude_Samples_Type) is
        begin
            -- Proporcionar el valor actual de la altitud
            Altitud := Read_Altitude;
        end Leer_Altitud;

        procedure Leer_Posicion_X(Posicion_X : out Joystick_Samples_Values) is
        begin
            -- Proporcionar el valor actual de la posición X
            Posicion_X := Read_Pitch;
        end Leer_Posicion_X;

        procedure Leer_Posicion_Y(Posicion_Y : out Joystick_Samples_Values) is
        begin
            -- Proporcionar el valor actual de la posición Y
            Posicion_Y := Read_Roll;
        end Leer_Posicion_Y;

    end Datos_Vuelo;
end datos_posalt_vel;
