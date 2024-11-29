-- Hecho por: Nicolás Clavo Collado, Adrián Ruiz Serrano y Adrián Colomer Ugrinovic

with devicesFSS_V1; use devicesFSS_V1;

package datos_aeronave is
   -- Objeto protegido para los datos de la aeronave
   protected aeronave is
      -- Leer los datos almacenados
      procedure Leer_Altitud (Altitud : out Altitude_Samples_Type);
      procedure Leer_Potencia (Potencia : out Power_Samples_Type);
      procedure Leer_Velocidad (Velocidad : out Speed_Samples_Type);
      procedure Leer_Pitch (Pitch : out Pitch_Samples_Type);
      procedure Leer_Roll (Roll : out Roll_Samples_Type);
      procedure Leer_Light_Intensity (Light : out Light_Samples_Type);
      procedure Leer_PilotPresence (PilotPresence : out PilotPresence_Samples_Type);
      procedure Leer_Distance (Distance : out Distance_Samples_Type);
      procedure Leer_Joystick (Joystick : out Joystick_Samples_Type);
      
   private
      Altitud : Altitude_Samples_Type := Initial_Altitude;
      Light_Intensity : Light_Samples_Type := 0;
      PilotPresence : PilotPresence_Samples_Type;
      Distance : Distance_Samples_Type := 0;
      Potencia_Motores : Power_Samples_Type := 0;
      Velocidad_Motores : Speed_Samples_Type := 0;
      Joystick : Joystick_Samples_Type;
      Pitch : Pitch_Samples_Type := 0;
      Roll : Roll_Samples_Type := 0;
   end aeronave;
end datos_aeronave;
