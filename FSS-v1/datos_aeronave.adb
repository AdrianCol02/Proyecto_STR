-- Hecho por: Nicolás Clavo Collado, Adrián Ruiz Serrano y Adrián Colomer Ugrinovic

with devicesFSS_V1; use devicesFSS_V1;
with Ada.Text_IO; use Ada.Text_IO;
with tools; use tools;

package body datos_aeronave is
   -- Implementación del objeto protegido
   protected body aeronave is

      -- Leer datos
      procedure Leer_Altitud (Altitud : out Altitude_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Altitud := aeronave.Altitud;
      end Leer_Altitud;

      procedure Leer_Potencia (Potencia : out Power_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Potencia := aeronave.Potencia_Motores;
      end Leer_Potencia;

      procedure Leer_Velocidad (Velocidad : out Speed_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Velocidad := aeronave.Velocidad_Motores;
      end Leer_Velocidad;

      procedure Leer_Pitch (Pitch : out Pitch_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Pitch := aeronave.Pitch;
      end Leer_Pitch;

      procedure Leer_Roll (Roll : out Roll_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Roll := aeronave.Roll;
      end Leer_Roll;

      procedure Leer_Light_Intensity (Light : out Light_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Light := aeronave.Light_Intensity;
      end Leer_Light_Intensity;

      procedure Leer_PilotPresence (PilotPresence : out PilotPresence_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         PilotPresence := aeronave.PilotPresence;
      end Leer_PilotPresence;

      procedure Leer_Distance (Distance : out Distance_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Distance := aeronave.Distance;
      end Leer_Distance;

      -- Actualizar datos
      procedure Actualizar_Altitud (Nueva_Altitud : in Altitude_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         aeronave.Altitud := Nueva_Altitud;
      end Actualizar_Altitud;

      procedure Actualizar_Potencia (Nueva_Potencia : in Power_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         aeronave.Potencia_Motores := Nueva_Potencia;
      end Actualizar_Potencia;

      procedure Actualizar_Velocidad (Nueva_Velocidad : in Speed_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         aeronave.Velocidad_Motores := Nueva_Velocidad;
      end Actualizar_Velocidad;

      procedure Actualizar_Pitch (Nuevo_Pitch : in Pitch_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         aeronave.Pitch := Nuevo_Pitch;
      end Actualizar_Pitch;

      procedure Actualizar_Roll (Nuevo_Roll : in Roll_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         aeronave.Roll := Nuevo_Roll;
      end Actualizar_Roll;

      procedure Actualizar_Light_Intensity (Nueva_Luz : in Light_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         aeronave.Light_Intensity := Nueva_Luz;
      end Actualizar_Light_Intensity;

      procedure Actualizar_PilotPresence (Nuevo_PilotPresence : in PilotPresence_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         aeronave.PilotPresence := Nuevo_PilotPresence;
      end Actualizar_PilotPresence;

      procedure Actualizar_Distance (Nueva_Distance : in Distance_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         aeronave.Distance := Nueva_Distance;
      end Actualizar_Distance;

   end aeronave;
end datos_aeronave;
