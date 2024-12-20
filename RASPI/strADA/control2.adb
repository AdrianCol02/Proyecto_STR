 
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Devices_A; use Devices_A;

procedure control2 is
     
  n: integer; -- variable para recibir valores de las funciones
  velocidad_global : Float;


  procedure Lanza_Tareas;  
   
  procedure Lanza_Tareas is
    task t1;
    task t2; 
    task t3;

    task body t1 is
       Ry : Integer := 0;
       Piloto_presente : Integer;
      begin
         put ("se ejecuta t1: "); New_Line;
         loop
			Ry := Read_Gyroscope_X_A;
			 Piloto_presente := read_infrared_A;
			 if Piloto_presente = 0 then
				if Ry > 30 then
				   moveServo_A (30);
				elsif Ry < -30 then
				   moveServo_A (-30);
				else
				   moveServo_A (Ry);
				end if;
			 end if;
			 delay (To_duration(Milliseconds (500)));
         end loop;
         
         --put_line ("termina t1");
      end t1; 

    task body t2 is
          Distancia : Float;
          Visibilidad : Integer;
          Altimetro : Integer;
          Velocidad : Float;
          Tiempo_colision : Float;
          Piloto_presente : Integer;
      begin
         put ("se ejecuta t2: "); New_Line;
         loop
			 Distancia := getDistance_A * 100.0; -- 50.0 equivale a 5 km en la escala real
			 Visibilidad := read_single_ADC_sensor_A(0);
			 Altimetro := (read_single_ADC_sensor_A(3) / 1023) * 10230;
			 Piloto_presente := read_infrared_A;
			 Velocidad := velocidad_global;
			 Tiempo_colision := Distancia / Velocidad;
			 put ("Distancia: "); put(Distancia,1,2,0); New_Line;
			 put ("Visibilidad: "); put(Visibilidad); New_Line;
			 put ("Tiempo colision: "); put(Tiempo_colision,1,2,0); New_Line;

			 if Distancia < 5000.0 then
				if Piloto_presente = 0 and Visibilidad > 500 then
				   if Tiempo_colision < 10.0 and Tiempo_colision > 5.0 then
					  set_led_1_A(1);
				   elsif Tiempo_colision < 5.0 then
					  moveServo_A(90);
					  set_led_1_A(1);
				   end if;
				else
				   if Tiempo_colision < 15.0 and Tiempo_colision > 10.0 then
					  set_led_1_A(1);
				   elsif Tiempo_colision < 10.0 then
					  moveServo_A(90);
					  set_led_1_A(1);
				   end if;
				   delay (To_duration(Milliseconds (3000)));
				end if;
			 end if;
			 moveServo_A(0);
			 set_led_1_A(0);
			 delay (To_duration(Milliseconds (250)));
         end loop;
         
         
         --put_line ("termina t2");
      end t2; 

    task body t3 is
         Velocidad : Float;
         Potencia_piloto : Integer;
      begin
         put_line ("se ejecuta t3: espera medio segundo"); 
         loop
			Potencia_piloto := read_single_ADC_sensor_A(2);
			Velocidad := Float (Potencia_piloto) * 1.2;
			put ("Potencia_piloto: "); put(Potencia_piloto); New_Line;
			put ("Velocidad: "); put(Velocidad,1,2,0); New_Line;
			if Velocidad > 1000.0 then
				set_led_2_A(1);
				Velocidad := 1000.0;
			elsif Velocidad < 300.0 then
				set_led_2_A(1);
				Velocidad := 300.0;
			elsif Velocidad >= 300.0 and Velocidad <= 1000.0 then
				set_led_2_A(0);
			end if;
			velocidad_global := Velocidad;
			put ("Velocidad tratamiento: "); put(velocidad_global,1,2,0); New_Line;
			delay (To_duration(Milliseconds (350)));
         end loop;
         
         --put_line ("termina t3");
      end t3; 

  begin 
     Put_Line ("Cuerpo del procedimiento Lanza_Tareas ");
  end Lanza_Tareas;
     
begin
    put_line ("Aaranca programa principal");
    n := Init_Devices_A;
    put ("Inicializados los dispositivos: "); put (n, 3); New_line;
    Lanza_Tareas;
end control2;
