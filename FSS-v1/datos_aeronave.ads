with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;

package datos_aeronave is
    
    type Datos_Type is record
        Altitud : Altitude_Samples_Type;
        Velocidad : Speed_Samples_Type;
        Potencia_Motores : Power_Samples_Type;
        Joystick_X : Joystick_Samples_Values;
        Joystick_Y : Joystick_Samples_Values;
        Posicion_X : Float; 
        Posicion_Y : Float; 
    end record;

    procedure Actualizar_Datos(Nuevos_Datos : Datos_Type);
    procedure Leer_Datos(Datos : out Datos_Type);
    
end datos_aeronave;