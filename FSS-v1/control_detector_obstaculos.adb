with Ada.Real_Time;
with Ada.Text_IO;
with devicesFSS_V1;
with datos_posalt_vel; -- Incluir el objeto protegido

package body control_detector_obstaculos is

   task body Supervisor_Obstaculos is
      Distancia         : devicesFSS_V1.Distance_Samples_Type;
      Velocidad         : devicesFSS_V1.Speed_Samples_Type;
      Altitud           : devicesFSS_V1.Altitude_Samples_Type;
      Visibilidad       : devicesFSS_V1.Light_Samples_Type;
      Piloto_Presente   : devicesFSS_V1.PilotPresence_Samples_Type;
      Tiempo_Colision   : Duration;
      Datos : Datos_Aeronave.Datos_Type;
   begin
      loop
         -- Leer datos de sensores
         devicesFSS_V1.Read_Distance(Distancia);
         Velocidad := datos_posalt_vel.Datos_Vuelo.Leer_Velocidad;
         Altitud := datos_posalt_vel.Datos_Vuelo.Leer_Altitud;
         devicesFSS_V1.Read_Light_Intensity(Visibilidad);
         Piloto_Presente := devicesFSS_V1.Read_PilotPresence;

         -- Actualizar datos en el objeto protegido
         Datos.Velocidad := Velocidad;
         Datos.Altitud := Altitud;
         Datos.Joystick_X := 0.0;  -- Puede ser modificado más adelante
         Datos.Joystick_Y := 0.0;  -- Puede ser modificado más adelante
         Datos.Potencia_Motores := 0;  -- Valor predeterminado

         Datos_Aeronave.Actualizar_Datos(Datos); -- Actualizar objeto protegido

         -- Calcular tiempo de colisión
         if Velocidad > 0 then
            Tiempo_Colision := Float(Distancia) / Float(Velocidad);
         else
            Tiempo_Colision := Tiempo_Alarma;  -- Valor alto si la velocidad es 0
         end if;

         -- Evaluación de condiciones para aviso o desvío
         if (Visibilidad < 500 or else Piloto_Presente = 0) then
            if Tiempo_Colision < Tiempo_Desvio_Visibilidad_Baja then
               -- Activa la tarea de desvío
               Desviador_Obstaculos.Set_Desvio := True;
            elsif Tiempo_Colision < Tiempo_Visibilidad_Baja then
               devicesFSS_V1.Alarm(4);
            end if;
         elsif Tiempo_Colision < Tiempo_Desvio then
            Desviador_Obstaculos.Set_Desvio := True;
         elsif Tiempo_Colision < Tiempo_Alarma then
            devicesFSS_V1.Alarm(4);
         end if;

         delay Periodo_Deteccion; -- Ejecutar cada 250 ms
      end loop;
   end Supervisor_Obstaculos;

   task body Desviador_Obstaculos is
      Altitud    : devicesFSS_V1.Altitude_Samples_Type;
      Set_Desvio : Boolean := False;
   begin
      loop
         -- Verificar si hay desvío pendiente
         if Set_Desvio then
            Altitud := devicesFSS_V1.Read_Altitude;

            -- Realizar maniobra basada en la altitud
            if Altitud <= 8500 then
               devicesFSS_V1.Set_Aircraft_Pitch(20); -- Incrementar pitch
            else
               devicesFSS_V1.Set_Aircraft_Roll(45); -- Realizar roll
            end if;

            delay 3.0;  -- Mantener maniobra por 3 segundos

            -- Estabilizar la nave después de la maniobra
            if Altitud <= 8500 then
               devicesFSS_V1.Set_Aircraft_Pitch(0); -- Estabilizar pitch
            else
               devicesFSS_V1.Set_Aircraft_Roll(0); -- Estabilizar roll
            end if;

            -- Reiniciar el estado del desvío
            Set_Desvio := False;

         else
            -- Sin desvío pendiente, esperar el siguiente ciclo
            delay Periodo_Deteccion;
         end if;
      end loop;
   end Desviador_Obstaculos;

end control_detector_obstaculos;
