with Ada.Real_Time; use Ada.Real_Time;
with devicesFSS_V1; use devicesFSS_V1;
with datos_posalt_vel;

package control_velocidad_aeronave is

   -- Constantes de control de velocidad (solo declaración en el archivo de especificación)
   Max_Velocidad            : constant Speed_Samples_Type := 1000;
   Min_Velocidad            : constant Speed_Samples_Type := 300;
   Velocidad_Critica        : constant Speed_Samples_Type := 250;
   Factor_Potenciometro     : constant Float := 1.2;
   Incremento_Cabeceo       : constant Speed_Samples_Type := 150;
   Incremento_Alabeo        : constant Speed_Samples_Type := 100;
   Incremento_CabeceoAlabeo : constant Speed_Samples_Type := 250;
   Intervalo_Control        : constant Time_Span := Milliseconds(300);

   -- Tareas para el control de velocidad de la aeronave
   task Transferir_Potencia_Piloto is
      -- Entrada eliminada si no hay necesidad de `accept` en el cuerpo
   end Transferir_Potencia_Piloto;

   task Control_Velocidad_Cabeceo is
      -- Entrada eliminada si no hay necesidad de `accept` en el cuerpo
   end Control_Velocidad_Cabeceo;

   task Control_Velocidad_Alabeo is
      -- Entrada eliminada si no hay necesidad de `accept` en el cuerpo
   end Control_Velocidad_Alabeo;

   task Control_Velocidad_CabeceoAlabeo is
      -- Entrada eliminada si no hay necesidad de `accept` en el cuerpo
   end Control_Velocidad_CabeceoAlabeo;

   task Control_Potencia_Motor is
      -- Entrada eliminada si no hay necesidad de `accept` en el cuerpo
   end Control_Potencia_Motor;

end control_velocidad_aeronave;
