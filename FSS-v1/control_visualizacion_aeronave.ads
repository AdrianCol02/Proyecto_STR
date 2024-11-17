with Ada.Real_Time; use Ada.Real_Time;

package control_visualizacion_aeronave is

    -- Intervalo de visualización: 1 segundo (1000 ms)
    intervalo_visualizacion : constant Time_Span := Milliseconds(1000);

    task visualizar_datos;

end control_visualizacion_aeronave;
