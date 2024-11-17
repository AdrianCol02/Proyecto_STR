with Ada.Real_Time; use Ada.Real_Time;
with devicesFSS_V1; use devicesFSS_V1;
with datos_posalt_vel;

package control_velocidad_aeronave is

   -- Constantes de control de velocidad
   Max_Velocidad            : constant Speed_Samples_Type := 1000;
   Min_Velocidad            : constant Speed_Samples_Type := 300;
   Velocidad_Critica        : constant Speed_Samples_Type := 250;
   Factor_Potenciometro     : constant Float := 1.2;
   Incremento_Cabeceo       : constant Speed_Samples_Type := 150;
   Incremento_Alabeo        : constant Speed_Samples_Type := 100;
   Incremento_CabeceoAlabeo : constant Speed_Samples_Type := 250;
   Intervalo_Control        : constant Time_Span := Milliseconds(300);

   -- Tarea consolidada para el control de velocidad de la aeronave
   task control_velocidad is
      pragma Priority (18);
   end control_velocidad; 

end control_velocidad_aeronave;
