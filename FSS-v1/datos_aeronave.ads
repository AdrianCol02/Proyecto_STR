with devicesFSS_V1; use devicesFSS_V1;

package datos_aeronave is
   -- Objeto protegido para los datos de la aeronave
   protected aeronave is
      -- Leer los datos almacenados
      procedure Leer_Altitud (Altitud : out Altitude_Samples_Type);
      procedure Leer_Potencia (Potencia : out Power_Samples_Type);
      procedure Leer_Velocidad (Velocidad : out Speed_Samples_Type);
      procedure Leer_Joystick (Joystick_X : out Joystick_Samples_Values; 
                               Joystick_Y : out Joystick_Samples_Values);
      procedure Leer_Posicion (Posicion_X : out Float; Posicion_Y : out Float);
      
      -- Actualizar los datos
      procedure Actualizar_Altitud (Nueva_Altitud : in Altitude_Samples_Type);
      procedure Actualizar_Potencia (Nueva_Potencia : in Power_Samples_Type);
      procedure Actualizar_Velocidad (Nueva_Velocidad : in Speed_Samples_Type);
      procedure Actualizar_Joystick (Nueva_Joystick_X : in Joystick_Samples_Values;
                                     Nueva_Joystick_Y : in Joystick_Samples_Values);
      procedure Actualizar_Posicion (Nueva_Posicion_X : in Float; Nueva_Posicion_Y : in Float);
   private
      Altitud : Altitude_Samples_Type := Initial_Altitude;
      Potencia_Motores : Power_Samples_Type := 0;
      Velocidad_Motores : Speed_Samples_Type := Read_Speed;
      Joystick_X : Joystick_Samples_Values := 0;
      Joystick_Y : Joystick_Samples_Values := 0;
      Posicion_X : Float := 0.0;
      Posicion_Y : Float := 0.0;
   end aeronave;
end datos_aeronave;
