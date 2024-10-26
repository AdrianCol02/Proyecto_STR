with Ada.Real_Time; use Ada.Real_Time;
with devicesFSS_V1; use devicesFSS_V1;
with Datos_Aeronave; 

package control_velocidad_aeronave is

   -- Constantes de control de velocidad
   Max_Velocidad : constant Speed_Samples_Type := 1000;
   Min_Velocidad : constant Speed_Samples_Type := 300;
   Factor_Potenciometro : constant Float := 1.2;
   Incremento_Cabeceo : constant Speed_Samples_Type := 150;
   Incremento_Alabeo : constant Speed_Samples_Type := 100;
   Incremento_CabeceoAlabeo : constant Speed_Samples_Type := 250;
   Intervalo_Control : constant Time_Span := Milliseconds(300);

   -- Tareas para el control de velocidad de la aeronave
   task Transferir_Potencia_Piloto is
      entry Set_Potencia(potenciometro : in Power_Samples_Type); -- Entrada para ajustar la potencia del piloto
   end Transferir_Potencia_Piloto;

   task Control_Velocidad_Cabeceo is
      entry Set_Cabeceo_Pitch(pitch : in Pitch_Samples_Type); -- Entrada para ajustar la velocidad basada en cabeceo
   end Control_Velocidad_Cabeceo;

   task Control_Velocidad_Alabeo is
      entry Set_Alabeo_Roll(roll : in Roll_Samples_Type); -- Entrada para ajustar la velocidad basada en alabeo
   end Control_Velocidad_Alabeo;

   task Control_Velocidad_CabeceoAlabeo is
      entry Set_Cabeceo_Alabeo(pitch : in Pitch_Samples_Type; roll : in Roll_Samples_Type); -- Entrada para combinar cabeceo y alabeo
   end Control_Velocidad_CabeceoAlabeo;

   task Control_Potencia_Motor is
      entry Ajustar_Potencia(potencia : in Power_Samples_Type); -- Entrada para ajustar directamente la potencia del motor
   end Control_Potencia_Motor;

   task Control_Velocidad_Avion is
      -- Esta tarea podría coordinar las interacciones generales de las demás tareas para gestionar la velocidad general de la aeronave
   end Control_Velocidad_Avion;

end control_velocidad_aeronave;
