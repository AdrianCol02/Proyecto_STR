with Ada.Real_Time; use Ada.Real_Time;
with datos_aeronave; use datos_aeronave;
with devicesFSS_V1; use devicesFSS_V1;

package control_modo_sistema is

   -- Declaración del modo del sistema
   type Modo_Sistema is (Manual, Automatico);

   -- Constantes del sistema
   Min_Velocidad : constant Speed_Samples_Type := 300;
   Min_Altitude  : constant Altitude_Samples_Type := 500;
   Max_Altitude  : constant Altitude_Samples_Type := 14000;

   -- Tareas concurrentes del sistema
   task Control_Modo;
   task Control_Avisos_Alarmas;
   task Control_Maniobras_Automaticas;

private
   -- Estado actual del modo del sistema (inicia en automático)
   Modo_Actual : Modo_Sistema := Automatico;
   Intervalo_Control : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(200);

end control_modo_sistema;
