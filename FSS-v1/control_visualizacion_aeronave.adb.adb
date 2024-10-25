with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;
with Datos_Aeronave; -- Incluir el objeto protegido

package body control_visualizacion_aeronave is

    -- Intervalo de visualización: 1 segundo (1000 ms)
    intervalo_visualizacion : constant Time_Span := Milliseconds(1000);

    task body visualizar_datos is
        Datos : Datos_Aeronave.Datos_Type; -- Datos a visualizar
    begin
        loop
            -- Leer datos del objeto protegido
            Datos_Aeronave.Leer_Datos(Datos);

            -- Mostrar los datos en el monitor
            Put_Line("=== Datos de la Aeronave ===");
            Put_Line("Altitud: " & Altitude_Samples_Type'Image(Datos.Altitud) & " m");
            Put_Line("Potencia de Motores: " & Integer'Image(Datos.Potencia_Motores));
            Put_Line("Velocidad de Motores: " & Speed_Samples_Type'Image(Datos.Velocidad) & " Km/h");
            Put_Line("Posición del Joystick: Jx=" & Joystick_Samples_Values'Image(Datos.Joystick_X) & 
                      " Jy=" & Joystick_Samples_Values'Image(Datos.Joystick_Y));
            Put_Line("Posición de la Aeronave: Nx=" & Float'Image(Datos.Posicion_X) & 
                      " Ny=" & Float'Image(Datos.Posicion_Y));

            Put_Line("============================");

            -- Esperar hasta el próximo ciclo (1 segundo)
            delay until Clock + intervalo_visualizacion;
        end loop;
    end visualizar_datos;

end control_visualizacion_aeronave;
