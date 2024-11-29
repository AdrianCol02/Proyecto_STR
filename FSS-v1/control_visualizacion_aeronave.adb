-- Hecho por: Nicolás Clavo Collado, Adrián Ruiz Serrano y Adrián Colomer Ugrinovic

with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;
with datos_aeronave;

package body control_visualizacion_aeronave is
    task body visualizar_datos is
         Altitud : Altitude_Samples_Type;
         Velocidad : Speed_Samples_Type;
         Potencia_Motores : Power_Samples_Type;
         Joystick : Joystick_Samples_Type;
         Pitch : Pitch_Samples_Type;
         Roll : Roll_Samples_Type;
         Distancia : Distance_Samples_Type;
         Start_Time, End_Time : Time;
         WCET : Duration := 0.0;
    begin
        loop
            Start_Time := Clock;

            -- Put_Line("Visualización de datos de la aeronave activada");
            Read_Joystick(Joystick);
            datos_aeronave.aeronave.Leer_Altitud(Altitud);
            datos_aeronave.aeronave.Leer_Velocidad(Velocidad);
            datos_aeronave.aeronave.Leer_Potencia(Potencia_Motores);
            Pitch := Pitch_Samples_Type(Joystick(x));
            Roll := Roll_Samples_Type(Joystick(y));

            -- Mostrar los datos en el monitor
            Put_Line("=== Datos de la Aeronave ===");
            Display_Altitude(Altitud);

            -- Calcular el tiempo de ejecución
            End_Time := Clock;
            WCET := Duration'Max(WCET, To_Duration(End_Time - Start_Time));
        end loop;
    end visualizar_datos;
end control_visualizacion_aeronave;
