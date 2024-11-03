-- pruebas_control_aeronave.adb
with Ada.Text_IO; use Ada.Text_IO;
with control_posicion_altitud;
with control_velocidad_aeronave;
with control_visualizacion_aeronave;
with Datos_Aeronave;

package body pruebas_control_aeronave is

    procedure Escenario_1 is
    begin
        -- Configuración inicial del escenario
        Datos_Aeronave.Datos_Vuelo.Actualizar_Datos(
            Velocidad      => 350.0,
            Altitud        => 2100.0,
            Posicion_X     => 0.0,
            Posicion_Y     => 0.0,
            Potencia_Motores => 50  -- Potencia media
        );
        
        -- Espera para observar el comportamiento de las tareas de control
        delay 5.0; -- Espera para observar el ajuste de pitch y altitud

        -- Imprimir resultados esperados de control en el monitor
        Put_Line("Escenario 1: Ajuste de Altitud en Condiciones Críticas");
        control_visualizacion_aeronave.visualizar_datos; -- Muestra los datos actualizados
    end Escenario_1;

    procedure Escenario_2 is
    begin
        -- Configuración inicial del escenario
        Datos_Aeronave.Datos_Vuelo.Actualizar_Datos(
            Velocidad      => 980.0,
            Altitud        => 5000.0,
            Posicion_X     => 0.0,
            Posicion_Y     => 40.0, -- Roll de 40 grados
            Potencia_Motores => 90  -- Potencia alta
        );
        
        -- Espera para observar el comportamiento de las tareas de control
        delay 5.0; -- Observación del ajuste de velocidad y alertas de alabeo

        -- Imprimir resultados esperados de control en el monitor
        Put_Line("Escenario 2: Corrección de Velocidad en Vuelo Rápido y Control de Alabeo");
        control_visualizacion_aeronave.visualizar_datos; -- Muestra los datos actualizados
    end Escenario_2;

    procedure Escenario_3 is
    begin
        -- Configuración inicial del escenario
        Datos_Aeronave.Datos_Vuelo.Actualizar_Datos(
            Velocidad      => 240.0,    -- Velocidad baja
            Altitud        => 3000.0,   -- Altitud dentro del rango seguro
            Posicion_X     => 15.0,     -- Pitch positivo de 15 grados
            Posicion_Y     => 0.0,
            Potencia_Motores => 30  -- Potencia baja
        );
        
        -- Espera para observar el comportamiento de las tareas de control
        delay 5.0; -- Observación de la corrección de velocidad y pitch

        -- Imprimir resultados esperados de control en el monitor
        Put_Line("Escenario 3: Respuesta a Baja Velocidad con Pitch Positivo");
        control_visualizacion_aeronave.visualizar_datos; -- Muestra los datos actualizados
    end Escenario_3;

end pruebas_control_aeronave;
