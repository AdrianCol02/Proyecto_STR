-- Hecho por: Nicolás Clavo Collado, Adrián Ruiz Serrano y Adrián Colomer Ugrinovic

with Ada.Real_Time; use Ada.Real_Time;
with devicesFSS_V1; use devicesFSS_V1;
with Datos_Aeronave; 

package control_posicion_altitud is

   -- Constantes de control de ángulos
   Max_Pitch_Angle : constant Pitch_Samples_Type := 30;
   Min_Pitch_Angle : constant Pitch_Samples_Type := -30;
   Max_Roll_Angle : constant Roll_Samples_Type := 45;
   Min_Roll_Angle : constant Roll_Samples_Type := -45;
   Alert_Roll_Angle : constant Roll_Samples_Type := 35;

   -- Constantes de Altitud
   Min_Altitude : constant Altitude_Samples_Type := 2000;
   Alert_Altitude_Low : constant Altitude_Samples_Type := 2500;
   Max_Altitude : constant Altitude_Samples_Type := 10000;
   Alert_Altitude_High : constant Altitude_Samples_Type := 9500;

   -- Tarea única para el control de la posición y altitud de la aeronave
   task posicion_altitud is
      pragma Priority (20);
   end posicion_altitud;

end control_posicion_altitud;
