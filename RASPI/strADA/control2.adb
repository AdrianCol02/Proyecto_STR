 
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Devices_A; use Devices_A;

procedure control2 is
     
  n: integer; -- variable para recibir valores de las funciones


  procedure Lanza_Tareas;  
   
  procedure Lanza_Tareas is
    task t1;
    task t2; 
    task t3;

    task body t1 is
       Ry : Integer := 0;
       Piloto_presente : integer;
      begin
         put ("se ejecuta t1: "); put (Valor, 3); New_Line;
         Ry := Read_Gyroscope_X_A;
         Piloto_presente := read_infrared_A;
         if Piloto_presente then
            if Ry > 30 then
               moveServo_A (30);
            elsif Ry < -30 then
               moveServo_A (-30);
            else
               moveServo_A (Ry);
            end if;
         end if;
         delay (To_duration(Milliseconds (500)));
         put_line ("termina t1");
      end t1; 

    task body t2 is
          Distancia : Float;
          Visibilidad : Integer;
          Altimetro : Integer;
          Potencia_piloto : Integer;
          Velocidad : Float;
          Tiempo_colision : Float;
          Piloto_presente : integer;
      begin
         put ("se ejecuta t2: "); put (Valor, 3); New_Line;
         Distancia := getDistance_A; -- 50.0 equivale a 5 km en la escala real
         Visibilidad := read_single_ADC_sensor_A(0);
         Altimetro := (read_single_ADC_sensor_A(3) / 1024) * 10230;
         Potencia_piloto := read_single_ADC_sensor_A(2);
         Piloto_presente := read_infrared_A;
         Velocidad := Potencia_piloto * 1.2;
         Tiempo_colision := Distancia / Velocidad;

         if Distancia < 50.0 then
            if Piloto_presente and Visibilidad > 500 then
               if Tiempo_colision < 10.0 then
                  set_led_1_A(1);
               else if Tiempo_colision < 5.0 then
                  moveServo_A(30);
                  set_led_1_A(1);
               end if;
            else
               if Tiempo_colision < 15.0 then
                  set_led_1_A(1);
               else if Tiempo_colision < 10.0 then
                  moveServo_A(30);
                  set_led_1_A(1);
               end if;
            end if;
            set_led_1_A(0);
         end if;
         moveServo_A(0);
         delay (To_duration(Milliseconds (250)));
         
         put_line ("termina t2");
      end t2; 

    task body t3 is
         Velocidad : Float;
         Potencia_piloto : Integer;
      begin
         put_line ("se ejecuta t3: espera medio segundo"); 
         Potencia_piloto := read_single_ADC_sensor_A(2);
         Velocidad := Potencia_piloto * 1.2;
         if Velocidad > 1000.0 then
            set_led_2_A(1);
            Velocidad := 1000.0;
         else if Velocidad < 300.0 then
            set_led_2_A(1);
            Velocidad := 300.0;
         end if;
         set_led_2_A(0);
         delay (To_duration(Milliseconds (500)));
         put_line ("termina t3");
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
