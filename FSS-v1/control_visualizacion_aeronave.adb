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
            datos_aeronave.aeronave.Leer_Altitud(Altitud);
            datos_aeronave.aeronave.Leer_Velocidad(Velocidad);
            datos_aeronave.aeronave.Leer_Potencia(Potencia_Motores);
            datos_aeronave.aeronave.Leer_Joystick(Joystick);
            datos_aeronave.aeronave.Leer_Pitch(Pitch);
            datos_aeronave.aeronave.Leer_Roll(Roll);


            -- Mostrar los datos en el monitor
            Put_Line("=== Datos de la Aeronave ===");
            Display_Altitude(Altitud);
            Display_Pilot_Power(Potencia_Motores);
            Display_Speed(Velocidad);
            Display_Joystick(Joystick);
            Display_Pitch(Pitch);
            Display_Roll(Roll);
            Put_Line("");
            Put_Line("============================");

            End_Time := Clock;
            WCET := Duration'Max(WCET, To_Duration(End_Time - Start_Time));

            Ada.Text_IO.Put_Line("WCET display: " & Duration'Image(WCET));

            -- Esperar hasta el próximo ciclo (1 segundo)
            delay until Clock + intervalo_visualizacion;
        end loop;
    end visualizar_datos;

end control_visualizacion_aeronave;