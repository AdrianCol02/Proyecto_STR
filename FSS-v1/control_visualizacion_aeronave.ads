-- Hecho por: Nicolás Clavo Collado, Adrián Ruiz Serrano y Adrián Colomer Ugrinovic

with Ada.Real_Time; use Ada.Real_Time;


package control_visualizacion_aeronave is

    -- Intervalo de visualización: 5 segundos (5000 ms)
    intervalo_visualizacion : constant Time_Span := Milliseconds(5000);

    task visualizar_datos is
        pragma Priority (17);
    end visualizar_datos;

end control_visualizacion_aeronave;
