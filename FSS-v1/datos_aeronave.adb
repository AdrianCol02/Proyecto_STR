-- Hecho por: Nicolás Clavo Collado, Adrián Ruiz Serrano y Adrián Colomer Ugrinovic

with devicesFSS_V1; use devicesFSS_V1;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with tools; use tools;

package body datos_aeronave is
   -- Implementación del objeto protegido
   protected body aeronave is

      -- Leer datos
      procedure Leer_Altitud (Altitud : out Altitude_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Altitud := devicesFSS_V1.Read_Altitude;
         aeronave.Altitud := Altitud;
      end Leer_Altitud;

      procedure Leer_Potencia (Potencia : out Power_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Potencia := devicesFSS_V1.Read_Power;
         aeronave.Potencia_Motores := Potencia;
      end Leer_Potencia;

      procedure Leer_Velocidad (Velocidad : out Speed_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Velocidad := devicesFSS_V1.Read_Speed;
         aeronave.Velocidad_Motores := Velocidad;
      end Leer_Velocidad;

      procedure Leer_Pitch (Pitch : out Pitch_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Pitch := devicesFSS_V1.Read_Pitch;
         aeronave.Pitch := Pitch;
      end Leer_Pitch;

      procedure Leer_Roll (Roll : out Roll_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Roll := devicesFSS_V1.Read_Roll;
         aeronave.Roll := Roll;
      end Leer_Roll;

      procedure Leer_Light_Intensity (Light : out Light_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Light := devicesFSS_V1.Read_Light_Intensity;
         aeronave.Light_Intensity := Light;
      end Leer_Light_Intensity;

      procedure Leer_PilotPresence (PilotPresence : out PilotPresence_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         PilotPresence := devicesFSS_V1.Read_PilotPresence;
         aeronave.PilotPresence := PilotPresence;
      end Leer_PilotPresence;

      procedure Leer_Distance (Distance : out Distance_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         Distance := devicesFSS_V1.Read_Distance;
         aeronave.Distance := Distance;
      end Leer_Distance;

      -- Actualizar datos
      procedure Actualizar_Altitud (Nueva_Altitud : in Altitude_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         devicesFSS_V1.Set_Altitude(Nueva_Altitud);
         aeronave.Altitud := Nueva_Altitud;
      end Actualizar_Altitud;

      procedure Actualizar_Potencia (Nueva_Potencia : in Power_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         devicesFSS_V1.Set_Power(Nueva_Potencia);
         aeronave.Potencia_Motores := Nueva_Potencia;
      end Actualizar_Potencia;

      procedure Actualizar_Velocidad (Nueva_Velocidad : in Speed_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         devicesFSS_V1.Set_Speed(Nueva_Velocidad);
         aeronave.Velocidad_Motores := Nueva_Velocidad;
      end Actualizar_Velocidad;

      procedure Actualizar_Pitch (Nuevo_Pitch : in Pitch_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         devicesFSS_V1.Set_Pitch(Nuevo_Pitch);
         aeronave.Pitch := Nuevo_Pitch;
      end Actualizar_Pitch;

      procedure Actualizar_Roll (Nuevo_Roll : in Roll_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         devicesFSS_V1.Set_Roll(Nuevo_Roll);
         aeronave.Roll := Nuevo_Roll;
      end Actualizar_Roll;

      procedure Actualizar_Light_Intensity (Nueva_Luz : in Light_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         devicesFSS_V1.Set_Light_Intensity(Nueva_Luz);
         aeronave.Light_Intensity := Nueva_Luz;
      end Actualizar_Light_Intensity;

      procedure Actualizar_PilotPresence (Nuevo_PilotPresence : in PilotPresence_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         devicesFSS_V1.Set_PilotPresence(Nuevo_PilotPresence);
         aeronave.PilotPresence := Nuevo_PilotPresence;
      end Actualizar_PilotPresence;

      procedure Actualizar_Distance (Nueva_Distance : in Distance_Samples_Type) is
      begin
         Execution_Time(Milliseconds(5));
         devicesFSS_V1.Set_Distance(Nueva_Distance);
         aeronave.Distance := Nueva_Distance;
      end Actualizar_Distance;

   end aeronave;
end datos_aeronave;
