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

   -- Tareas para el control de la posición y altitud de la aeronave
   task control_pitch is
      entry Set_Aircraft_Pitch(pitch : in Pitch_Samples_Type);
   end control_pitch;

   task control_altitude is
   end control_altitude;

   task control_roll is
      entry Set_Aircraft_Roll(roll : in Roll_Samples_Type);
   end control_roll;

   -- Actualización y lectura de datos en el objeto protegido
   procedure Actualizar_Datos_Aeronave;

end control_posicion_altitud;
