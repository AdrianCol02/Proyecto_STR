with Ada.Text_IO; use Ada.Text_IO;
with devicesFSS_V1; use devicesFSS_V1;
with datos_aeronave; use datos_aeronave;
with datos_posalt_vel; use datos_posalt_vel;

package body control_modo_sistema is

   -- Tareas Concurrentes
   task body Control_Modo is
   begin
      loop
         if Read_PilotButton = 1 then
            if Modo_Actual = Automatico then
               Modo_Actual := Manual;
               Put_Line("Modo de control cambiado a manual");
            else
               Modo_Actual := Automatico;
               Put_Line("Modo de control cambiado a automático");
            end if;
         end if;

         -- Usamos el intervalo de control para ejecutar cada 200ms
         delay until Ada.Real_Time.Clock + Intervalo_Control;
      end loop;
   end Control_Modo;

   task body Control_Avisos_Alarmas is
      Velocidad_Actual : Speed_Samples_Type;  -- Tipo para almacenar la velocidad actual
      Altitud_Actual : Altitude_Samples_Type;  -- Tipo para almacenar la altitud actual
   begin
      loop
         -- Leer datos de velocidad y altitud de la aeronave
         datos_aeronave.aeronave.Leer_Velocidad(Velocidad_Actual);  -- Leer velocidad
         datos_aeronave.aeronave.Leer_Altitud(Altitud_Actual);  -- Leer altitud

         -- Generar avisos y alarmas
         if Velocidad_Actual < Min_Velocidad then
            Light_2(On);
            Alarm(3);
            Display_Message("Velocidad baja");
         elsif Altitud_Actual < Min_Altitude then
            Light_1(On);
            Display_Message("Altitud baja, ascienda");
         elsif Altitud_Actual > Max_Altitude then
            Light_1(On);
            Display_Message("Altitud alta, descienda");
         else
            Light_1(Off);
            Light_2(Off);
         end if;

         -- Usamos el intervalo de control para ejecutar cada 200ms
         delay until Ada.Real_Time.Clock + Intervalo_Control;
      end loop;
   end Control_Avisos_Alarmas;

   task body Control_Maniobras_Automaticas is
      Velocidad_Actual : Speed_Samples_Type;  -- Tipo para la velocidad
      Altitud_Actual : Altitude_Samples_Type;  -- Tipo para la altitud
      Pitch_Actual : Pitch_Samples_Type;  -- Tipo para el cabeceo (pitch)
   begin
      loop
         -- Realizar maniobras solo en modo automático
         if Modo_Actual = Automatico then
            -- Leer datos de velocidad, altitud y pitch de la aeronave
            datos_aeronave.aeronave.Leer_Velocidad(Velocidad_Actual);  -- Leer velocidad
            datos_aeronave.aeronave.Leer_Altitud(Altitud_Actual);  -- Leer altitud

            -- Control de altitud
            if Altitud_Actual <= Min_Altitude then
               Set_Aircraft_Pitch(10);  -- Asciende automáticamente
               datos_aeronave.aeronave.Actualizar_Pitch(10);
               datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(10);
               Display_Message("Ascendiendo automáticamente");
            elsif Altitud_Actual >= Max_Altitude then
               Set_Aircraft_Pitch(-10);  -- Desciende automáticamente
               datos_aeronave.aeronave.Actualizar_Pitch(-10);
               datos_posalt_vel.Datos_Vuelo.Actualizar_Pitch(-10);
               Display_Message("Descendiendo automáticamente");
            end if;

            -- Control de velocidad
            if Velocidad_Actual < Min_Velocidad then
               Set_Speed(Min_Velocidad);  -- Aumenta la velocidad automáticamente
               datos_aeronave.aeronave.Actualizar_Velocidad(Min_Velocidad);
               datos_posalt_vel.Datos_Vuelo.Actualizar_Velocidad(Min_Velocidad);
               Display_Message("Aumentando velocidad automáticamente");
            end if;
         else
            -- En modo manual, no se realizan maniobras automáticas
            Display_Message("Modo manual: Sin maniobras automáticas");
         end if;

         -- Usamos el intervalo de control para ejecutar cada 200ms
         delay until Ada.Real_Time.Clock + Intervalo_Control;
      end loop;
   end Control_Maniobras_Automaticas;

end control_modo_sistema;
