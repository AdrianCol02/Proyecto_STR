with Ada.Real_Time; use Ada.Real_Time;
with devicesFSS_V1; use devicesFSS_V1;

package control_velocidad_aeronave is

    task Transferir_Potencia_Piloto; -- Transfiere la potencia indicada por el piloto
    task Control_Velocidad_Cabeceo;  -- Controla la velocidad de la aeronave según el cabeceo
    task Control_Velocidad_Alabeo;  -- Controla la velocidad de la aeronave según el alabeo
    task Control_Velocidad_CabeceoAlabeo; -- Controla la velocidad de la aeronave según el cabeceo y alabeo
    task Control_Potencia_Motor; -- Controla la potencia del motor
    task Control_Velocidad_Avion; -- Controla la velocidad del avión(Desarrollo más adelante)

end control_velocidad_aeronave;
