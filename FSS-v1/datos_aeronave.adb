with devicesFSS_V1; use devicesFSS_V1;
with Ada.Text_IO; use Ada.Text_IO;

package body datos_aeronave is
   -- Implementación del objeto protegido
   protected body aeronave is
      -- Leer datos
      procedure Leer_Altitud (Altitud : out Altitude_Samples_Type) is
      begin
         Altitud := aeronave.Altitud;
      end Leer_Altitud;

      procedure Leer_Potencia (Potencia : out Power_Samples_Type) is
      begin
         Potencia := aeronave.Potencia_Motores;
      end Leer_Potencia;

      procedure Leer_Velocidad (Velocidad : out Speed_Samples_Type) is
      begin
         Velocidad := aeronave.Velocidad_Motores;
      end Leer_Velocidad;

      procedure Leer_Joystick (Joystick_X : out Joystick_Samples_Values; 
                               Joystick_Y : out Joystick_Samples_Values) is
      begin
         Joystick_X := aeronave.Joystick_X;
         Joystick_Y := aeronave.Joystick_Y;
      end Leer_Joystick;

      procedure Leer_Posicion (Posicion_X : out Float; Posicion_Y : out Float) is
      begin
         Posicion_X := aeronave.Posicion_X;
         Posicion_Y := aeronave.Posicion_Y;
      end Leer_Posicion;

      -- Actualizar datos
      procedure Actualizar_Altitud (Nueva_Altitud : in Altitude_Samples_Type) is
      begin
         aeronave.Altitud := Nueva_Altitud;
         Display_Altitude(Nueva_Altitud);
      end Actualizar_Altitud;

      procedure Actualizar_Potencia (Nueva_Potencia : in Power_Samples_Type) is
      begin
         aeronave.Potencia_Motores := Nueva_Potencia;
         Display_Pilot_Power(Nueva_Potencia);
      end Actualizar_Potencia;

      procedure Actualizar_Velocidad (Nueva_Velocidad : in Speed_Samples_Type) is
      begin
         aeronave.Velocidad_Motores := Nueva_Velocidad;
         Display_Speed(Nueva_Velocidad);
      end Actualizar_Velocidad;

      procedure Actualizar_Joystick (Nueva_Joystick_X : in Joystick_Samples_Values; 
                                     Nueva_Joystick_Y : in Joystick_Samples_Values) is
      begin
         aeronave.Joystick_X := Nueva_Joystick_X;
         aeronave.Joystick_Y := Nueva_Joystick_Y;
         Display_Joystick((x => Nueva_Joystick_X, y => Nueva_Joystick_Y));
      end Actualizar_Joystick;

      procedure Actualizar_Posicion (Nueva_Posicion_X : in Float; Nueva_Posicion_Y : in Float) is
      begin
         aeronave.Posicion_X := Nueva_Posicion_X;
         aeronave.Posicion_Y := Nueva_Posicion_Y;
      end Actualizar_Posicion;
   end aeronave;
end datos_aeronave;
