with Ada.Real_Time; use Ada.Real_Time;
with devicesFSS_V1; use devicesFSS_V1;

package control_modo_sistema is

    type Modo_Sistema is (Manual, Automatico); -- Modos de control del sistema

    Modo_Inicial : constant Modo_Sistema := Automatico; -- Modo de control inicial automático, se da por hecho que comienza en el aire.

    -- Tareas para el control del modo del sistema de vuelo

    -- Se encarga de cambiar el modo de control del avión
    task Control_Modo is
    end Control_Modo;

    -- Tarea para el control de avisos y alarmas del avión
    task Control_Avisos_Alarmas is 
    end Control_Avisos_Alarmas;
    
    -- Tarea para el control de las maniobras automáticas del avión
    task Control_Maniobras_Automaticas is
    end Control_Maniobras_Automaticas;

end control_modo_sistema;