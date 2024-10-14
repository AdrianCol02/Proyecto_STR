with Ada.Real_Time; use Ada.Real_Time;
with devicesFSS_V1; use devicesFSS_V1;

package body Control_Velocidad_Aeronave is

    --Vamos a hacer uso de constantes para realizar las pruebas en un entorno controlado, más adelante se podrán modificar con el objeto protegido
    Max_Velocidad : constant Float:= 1000.0;
    Min_Velocidad : constant Float:= 300.0;
    Factor_Potenciometro : constant Float:= 1.2;
    Incremento_Cabeceo : constant Float:= 150.0;
    Incremento_Alabeo : constant Float:= 100.0;
    Incremento_CabeceoAlabeo : constant Float:= 250.0;
    Intervalo_Control : constant Time_Span:= Milliseconds(300);

    task body Transferir_Potencia_Piloto is 
        Potenciometro : Integer;
        Velocidad_Potencia : Float;
    begin
        loop
            Potenciometro := Read_Power(Power_Samples_Type);
            Velocidad_Potencia := Float(Potenciometro) * Factor_Potenciometro;

            if Velocidad_Potencia > Max_Velocidad then
                Velocidad_Potencia := Max_Velocidad;
                Light_2(ON);
            elsif Velocidad_Potencia < Min_Velocidad then
                Velocidad_Potencia := Min_Velocidad;
                Light_2(ON);
            end if;

            Set_Speed(Velocidad_Potencia); --Ajusta la velocidad de la aeronave según la potencia indicada por el piloto

            delay until Clock + Intervalo_Control;
        end loop;

    end Transferir_Potencia_Piloto;

    task body Control_Velocidad_Cabeceo is
        Velocidad_Actual : Float;
    begin
        loop
            Velocidad_Actual := Read_Speed;

            if Read_Pitch and then Velocidad_Actual < Max_Velocidad then
                Velocidad_Actual := Velocidad_Actual + Incremento_Cabeceo;
                if Velocidad_Actual > Max_Velocidad then
                    Velocidad_Actual := Max_Velocidad;
                    Light_2(ON);
                end if;
                Set_Speed(Velocidad_Actual);
            end if;

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Velocidad_Cabeceo;

    task body Control_Velocidad_Alabeo is
        Velocidad_Actual : Float;
    begin
        loop
            Velocidad_Actual := Read_Speed;

            if Read_Roll and then Velocidad_Actual < Max_Velocidad then
                Velocidad_Actual := Velocidad_Actual + Incremento_Alabeo;
                if Velocidad_Actual > Max_Velocidad then
                    Velocidad_Actual := Max_Velocidad;
                    Light_2(ON);
                end if;
                Set_Speed(Velocidad_Actual);
            end if;

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Velocidad_Alabeo;

    task body Control_Velocidad_CabeceoAlabeo is
        Velocidad_Actual : Float;
    begin
        loop
            Velocidad_Actual := Read_Speed;

            if Read_Pitch and then Read_Roll and then Velocidad_Actual < Max_Velocidad then
                Velocidad_Actual := Velocidad_Actual + Incremento_CabeceoAlabeo;
                if Velocidad_Actual > Max_Velocidad then
                    Velocidad_Actual := Max_Velocidad;
                    Light_2(ON);
                end if;
                Set_Speed(Velocidad_Actual);
            end if;

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Velocidad_CabeceoAlabeo;

    task body Control_Potencia_Motor is
        Velocidad_Actual : Float;
    begin
        loop
            Velocidad_Actual := Read_Speed;

            if Velocidad_Actual < Min_Velocidad then
                Light_2(ON);
            end if;

            if Velocidad_Actual < 250.0 then
                Set_Speed(300.0);
            end if;

            delay until Clock + Intervalo_Control;
        end loop;
    end Control_Potencia_Motor;

    task body Control_Velocidad_Avion is
    begin
        --Se desarrollará en futuras versiones ya que no conocemos si hacen presencia en ella otros módulos de control
    end Control_Velocidad_Avion;

end Control_Velocidad_Aeronave;