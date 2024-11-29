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
         devicesFSS_V1.Read_Power(Potencia);
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
         devicesFSS_V1.Read_Light_Intensity(Light);
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
         devicesFSS_V1.Read_Distance(Distance);
         aeronave.Distance := Distance;
      end Leer_Distance;

      procedure Leer_Joystick (Joystick : out Joystick_Samples_Type) is
      begin
         Execution_Time(Milliseconds(2));
         devicesFSS_V1.Read_Joystick(Joystick);
         aeronave.Joystick := Joystick;
      end Leer_Joystick;
   end aeronave;
end datos_aeronave;
