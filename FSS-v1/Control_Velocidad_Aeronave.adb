with Ada.Real_Time; use Ada.Real_Time;
with devicesFSS_V1; use devicesFSS_V1;

package body control_velocidad_aeronave is

    --Vamos a hacer uso de constantes para realizar las pruebas en un entorno controlado, más adelante se podrán modificar con el objeto protegido
    Max_Velocidad : constant Speed_Samples_Type:= 1000;
    Min_Velocidad : constant Speed_Samples_Type:= 300;
    Velocidad_Critica : constant Speed_Samples_Type:= 250;
    Factor_Potenciometro : constant Float:= 1.2;
    Incremento_Cabeceo : constant Speed_Samples_Type:= 150;
    Incremento_Alabeo : constant Speed_Samples_Type:= 100;
    Incremento_CabeceoAlabeo : constant Speed_Samples_Type:= 250;
    Intervalo_Control : constant Time_Span:= Milliseconds(300);

    task body Transferir_Potencia_Piloto is 
        Potenciometro : Power_Samples_Type;
        Velocidad_Potencia : Float;
        Nueva_Velocidad : Speed_Samples_Type;
    begin
        loop
            Read_Power(Potenciometro);
            Velocidad_Potencia := Float(Potenciometro) * Factor_Potenciometro;

            -- Convertir la velocidad calculada al tipo Speed_Samples_Type y asegurar que esté en el rango permitido
            if Velocidad_Potencia > Float(Max_Velocidad) then
                Nueva_Velocidad := Max_Velocidad;
                Light_2(On);
            elsif Velocidad_Potencia < Float(Min_Velocidad) then
                Nueva_Velocidad := Min_Velocidad;
                Light_2(On);
            else
                Nueva_Velocidad := Speed_Samples_Type(Velocidad_Potencia);
            end if;

            Set_Speed(Nueva_Velocidad); -- Ajusta la velocidad de la aeronave según la potencia indicada por el piloto

            delay until Clock + Intervalo_Control;
        end loop;

    end Transferir_Potencia_Piloto;

    task body Control_Velocidad_Cabeceo is
        Velocidad_Actual : Speed_Samples_Type;
    begin
        loop
            Velocidad_Actual := Read_Speed;

            if Read_Pitch > 0 and then Velocidad_Actual < Max_Velocidad then
                Velocidad_Actual := Velocidad_Actual + Incremento_Cabeceo;
                if Velocidad_Actual > Max_Velocidad then
                    Velocidad_Actual := Max_Velocidad;
                    Light_2(On);
                end if;
                Set_Speed(Velocidad_Actual);
            end if;

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Velocidad_Cabeceo;

    task body Control_Velocidad_Alabeo is
        Velocidad_Actual : Speed_Samples_Type;
    begin
        loop
            Velocidad_Actual := Read_Speed;

            if Read_Roll > 0 and then Velocidad_Actual < Max_Velocidad then
                Velocidad_Actual := Velocidad_Actual + Incremento_Alabeo;
                if Velocidad_Actual > Max_Velocidad then
                    Velocidad_Actual := Max_Velocidad;
                    Light_2(On);
                end if;
                Set_Speed(Velocidad_Actual);
            end if;

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Velocidad_Alabeo;
    
    task body Control_Velocidad_CabeceoAlabeo is
        Velocidad_Actual : Speed_Samples_Type;
    begin
        loop
            Velocidad_Actual := Read_Speed;

            if Read_Pitch > 0 and then Read_Roll > 0 and then Velocidad_Actual < Max_Velocidad then
                Velocidad_Actual := Velocidad_Actual + Incremento_CabeceoAlabeo;
                if Velocidad_Actual > Max_Velocidad then
                    Velocidad_Actual := Max_Velocidad;
                    Light_2(On);
                end if;
                Set_Speed(Velocidad_Actual);
            end if;

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Velocidad_CabeceoAlabeo;

    task body Control_Potencia_Motor is
        Velocidad_Actual : Speed_Samples_Type;
    begin
        loop
            Velocidad_Actual := Read_Speed;

            -- Avisar al piloto si la velocidad está por debajo del mínimo permitido
            if Velocidad_Actual < Min_Velocidad then
                Light_2(On);
                Alarm(3);
            end if;

            -- Ajustar la velocidad si cae por debajo de la velocidad crítica de 250 km/h
            if Velocidad_Actual < Velocidad_Critica then
                Alarm(5);
                Set_Speed(Min_Velocidad);
            end if;

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Potencia_Motor;

    task body Control_Velocidad_Avion is
    begin
        --Se desarrollará en futuras versiones ya que no conocemos si hacen presencia en ella otros módulos de control
    end Control_Velocidad_Avion;

end control_velocidad_aeronave;