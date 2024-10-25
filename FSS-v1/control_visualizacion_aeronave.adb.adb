with Ada.Real_Time; use Ada.Real_Time;
with devicesFSS_V1; use devicesFSS_V1;
with Ada.textIO; use Ada.textIO;

package body control_visualizacion_aeronave is

    -- Intervalo de visualización: 1 segundo (1000 ms)
    intervalo_visualizacion : constant Time_Span := Miliseconds(1000);

    task body visualizar_datos is
        altitude : Float;
        potencia_motores : Integer;
        velocidad_motores : Float;
        joystick_x, joystick_y : Float;
        posicion_x, posicion_y : Float;
        mensaje_aviso : String(1..50);
    begin
        loop
        -- leer datos de sensonres y actuadores
        altitude := Read_altitude;
        potencia_motores := Read_power(Power_Sample_Type);
        velocidad_motores := Read_Speed;
        joystick_x := Read_joystick_x;
        joystick_y := Read_joystick_y;
        posicion_x := Read_Picth;
        posicion_y := Real_Roll;

        -- Leer mensajes de aviso (puede estar vacío si no hay avisos)
        mensaje_aviso := Get_Warning_Message;

        -- Mostrar los datos en el monitor
        Put_Line("=== Datos de la Aeronave ===");
        Put_Line("Altitud: " & Float'Image(altitude) & " m");
        Put_Line("Potencia de Motores: " & Integer'Image(potencia_motores));
        Put_Line("Velocidad de Motores: " & Float'Image(velocidad_motores) & " Km/h");
        Put_Line("Posición del Joystick: Jx=" & Float'Image(joystick_X) & " Jy=" & Float'Image(joystick_Y));
        Put_Line("Posición de la Aeronave: Nx=" & Float'Image(posicion_X) & " Ny=" & Float'Image(posicion_Y));

        -- Mostrar mensaje de aviso si existe
        if mensaje_aviso /= "" then
            Put_Line("Aviso: " & mensaje_aviso);
        end if;

        Put_Line("============================");

            -- Esperar hasta el próximo ciclo (1 segundo)
            delay until Clock + Intervalo_Visualizacion;
        end loop;
    end Visualizar_Datos;

end visualizacion_aeronave;