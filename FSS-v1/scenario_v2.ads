with Ada.Real_Time; use Ada.Real_Time;
with devicesfss_v1; use devicesfss_v1;

package Scenario_V2 is

    ---------------------------------------------------------------------
    ------ Access time for devices
    ---------------------------------------------------------------------
    WCET_Distance: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    WCET_Light: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    
    WCET_Joystick: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    WCET_PilotPresence: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    WCET_PilotButton: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    
    WCET_Power: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(4);
    
    WCET_Speed: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(7);
    WCET_Altitude: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(18);

    WCET_Pitch: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(20);
    WCET_Roll: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(18);

    WCET_Display: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(15);
    WCET_Alarm: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);

    ---------------------------------------------------------------------
    ------ SCENARIO ----------------------------------------------------- 
    ---------------------------------------------------------------------
    -- Initial_Altitude: Altitude_Samples_Type := 8000;
    
    ---------------------------------------------------------------------
    ------ DISTANCE OK---------------------------------------------------
    cantidad_datos_Distancia: constant := 200;
    type Indice_Secuencia_Distancia is mod cantidad_datos_Distancia;
    type tipo_Secuencia_Distancia is array (Indice_Secuencia_Distancia) of Distance_Samples_Type;

    Distance_Simulation: tipo_Secuencia_Distancia :=  -- next sample every 100ms.
            ( 4440,4440,4440,4440,4440, 4440,4440,4440,4440,4440,   -- 1s.
              3330,3330,3330,3330,3330, 3330,3330,3330,3330,3330,   -- 2s.
              4440,4440,4440,4440,4440, 4440,4440,4440,4440,4440,   -- 3s.
              4440,4440,4440,4440,4440, 4440,4440,4440,4440,4440,   -- 4s.  ! objeto detectado
              4440,4440,4440,4440,4440, 4440,4440,4440,4440,4440,   -- 5s.
              3330,3330,3330,3330,3330, 3330,3330,3330,3330,3330,   -- 6s.
              3000,3000,3000,3000,3000, 3000,3000,3000,3000,3000,   -- 7s.
              2400,2400,2400,2400,2400, 2400,2400,2400,2400,2400,   -- 8s.  !!! objeto proximo
              1999,1999,1999,1999,1999, 1999,1999,1999,1999,1999,   -- 9s.
              0990,0990,0990,0990,0990, 0990,0990,0990,0990,0990,   -- 10s.
              0411,0411,0411,0411,0411, 0411,0411,0411,0411,0411,   -- 11s. !!!! peligro colisión
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 12s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 13s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 14s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 15s. 
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 16s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 17s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 18s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555,   -- 19s.
              5555,5555,5555,5555,5555, 5555,5555,5555,5555,5555);  -- 20s.
                   
    ---------------------------------------------------------------------
    ------ LIGHT OK------------------------------------------------------

    cantidad_datos_Light: constant := 200;
    type Indice_Secuencia_Light is mod cantidad_datos_Light;
    type tipo_Secuencia_Light is array (Indice_Secuencia_Light) of Light_Samples_Type;

    Light_Intensity_Simulation: tipo_Secuencia_Light :=  -- 1 muestra cada 100ms.
                 ( 700,700,700,700,700, 700,700,700,700,700,   -- 1s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 2s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 3s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 4s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 5s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 6s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 7s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 8s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 9s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 10s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 11s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 12s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 13s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 14s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 15s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 16s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 17s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 18s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 19s.
                   700,700,700,700,700, 700,700,700,700,700);  -- 20s.
    ---------------------------------------------------------------------
    ------ JOYSTICK OK---------------------------------------------------

    cantidad_datos_Joystick: constant := 200;
    type Indice_Secuencia_Joystick is mod cantidad_datos_Joystick;
    type tipo_Secuencia_Joystick is array (Indice_Secuencia_Joystick) 
                                             of Joystick_Samples_Type;

    Joystick_Simulation: tipo_Secuencia_Joystick :=  -- 1 muestra cada 100ms.
                ((+81,+03),(+81,+03),(+82,+01),(+83,+00),(+81,-03),  
                 (+01,+03),(-01,+03),(-02,+01),(+03,+00),(+01,-03),  --1s.
 
                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (+01,+03),(-01,+03),(-02,+01),(+03,+00),(+01,-03),  --2s.

                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (+15,+03),(+15,+03),(+15,+01),(+20,+00),(+20,-03),  --3s.

                 (+25,+03),(+25,+03),(+35,+01),(+35,+00),(+35,-03),  
                 (+37,+03),(+37,+03),(+37,+01),(+45,+00),(+45,-03),  --4s. inicia ascenso

                 (+47,+03),(+47,+03),(+47,+01),(+45,+00),(+45,-03),  
                 (+47,+03),(+47,+03),(+47,+01),(+46,+00),(+46,-03),  --5s. !! ascenso brusco
                  
                 (+47,+20),(+47,+20),(+47,+21),(+45,+30),(+45,+33),  
                 (+47,+33),(+47,+43),(+47,+41),(+46,+40),(+46,+43),  --6s. rotación derecha
 
                 (+47,+50),(+47,+50),(+47,+51),(+45,+60),(+45,+63),  
                 (+47,+73),(+47,+73),(+47,+71),(+46,+70),(+46,+73),  --7s. !! ascenso y rotacion bruscos

                 (+47,+30),(+47,+30),(+47,+21),(+45,+05),(+45,+05),  
                 (+45,+03),(+45,+02),(+45,+02),(+45,+02),(+45,+00),  --8s. !! mantiene ascenso brusco

                 (+25,+03),(+25,+02),(+20,+02),(+18,+02),(+15,+00),  
                 (+15,+03),(+05,+02),(+05,+02),(+05,+02),(+05,+00),  --9s. anula el ascenso

                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  --10s.
                 
                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (+01,+03),(-01,+03),(-02,+01),(+03,+00),(+01,-03),  --11s.
 
                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (+01,+03),(-01,+03),(-02,+01),(+03,+00),(+01,-03),  --12s.

                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (-15,+03),(-15,+03),(-15,+01),(-20,+00),(-20,-03),  --13s.

                 (-25,+03),(-25,+03),(-35,+01),(-35,+00),(-35,-03),  
                 (-37,+03),(-37,+03),(-37,+01),(-45,+00),(-45,-03),  --14s.

                 (-47,+03),(-47,+03),(-47,+01),(-45,+00),(-45,-03),  
                 (-47,+03),(-47,+03),(-47,+01),(-46,+00),(-46,-03),  --15s.
                  
                 (-47,+00),(-47,+00),(-47,+01),(-45,+00),(-45,-03),  
                 (-47,+03),(-47,+03),(-47,+01),(-46,+00),(-46,-03),  --16s.
 
                 (-17,+00),(-17,+00),(+17,+01),(-15,+00),(-15,-03),  
                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  --17s.

                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  --18s.

                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (+01,+03),(-01,+03),(-02,+01),(+03,+00),(+01,-03),  --19s.

                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (+01,+03),(-01,+03),(-02,+01),(+03,+00),(+01,-03));  --20s.
                 
    ---------------------------------------------------------------------
    ------ POWER OK------------------------------------------------------
    cantidad_datos_Power: constant := 200;
    type Indice_Secuencia_Power is mod cantidad_datos_Power;
    type tipo_Secuencia_Power is array (Indice_Secuencia_Power) of Power_Samples_Type;

    Power_Simulation: tipo_Secuencia_Power :=  -- next sample every 100ms.
                 ( 800,800,800,800,800, 800,800,800,800,800,   -- 1s.
                   800,800,800,800,800, 800,800,800,800,800,   -- 2s.
                   800,800,800,800,800, 700,700,700,700,700,   -- 3s.
                   700,700,700,700,700, 700,700,700,700,700,   -- 4s.   disminucion
                   600,600,600,600,600, 600,600,600,600,600,   -- 5s.
                   900,900,900,900,900, 900,900,900,900,900,   -- 6s.   !! aumento brusco
                   900,900,900,900,900, 900,900,900,900,900,   -- 7s.
                   1000,1000,1000,1000,1000, 1000,1000,1000,1000,1000, -- 8s.  !!!! muy alta
                   1020,1020,1020,1020,1020, 1020,1020,1020,1020,1020, -- 9s.  !!!!
                   1020,1020,1020,1020,1020, 1020,1020,1020,1020,1020, -- 10s. !!!!
                   800,800,800,800,800, 800,800,800,800,800,   -- 11s.
                   800,800,800,800,800, 800,800,800,800,800,   -- 12s.
                   800,800,800,800,800, 800,800,800,800,800,   -- 13s.
                   800,800,800,800,800, 800,800,800,800,800,   -- 14s.
                   800,800,800,800,800, 800,800,800,800,800,   -- 15s.
                   900,900,900,900,900, 900,900,900,900,900,   -- 16s.
                   900,900,900,900,900, 900,700,500,400,300,   -- 17s.
                   150,100,100,100,100, 100,100,100,100,100,   -- 18s.  !!!! muy baja
                   110,110,110,110,103, 103,103,100,100,100,   -- 19s.  !!!!
                   900,900,800,800,800, 800,800,800,800,800 ); -- 20s.


    ---------------------------------------------------------------------
    ------ PILOT'S PRESENCE ---------------------------------------------

    cantidad_datos_PilotPresence: constant := 200;
    type Indice_Secuencia_PilotPresence is mod cantidad_datos_PilotPresence;
    type tipo_Secuencia_PilotPresence is array (Indice_Secuencia_PilotPresence) of PilotPresence_Samples_Type;

    PilotPresence_Simulation: tipo_Secuencia_PilotPresence :=  -- 1 muestra cada 100ms.
                 ( 1,1,1,1,1, 1,1,1,1,1,   -- 1s. 
                   1,1,1,1,1, 1,1,1,1,1,   -- 2s.
                   1,1,1,1,1, 1,1,1,1,1,   -- 3s.
                   1,1,1,1,1, 1,1,0,1,0,   -- 4s. 
                   1,1,1,1,1, 1,1,1,1,1,   -- 5s.
                   1,1,1,1,1, 1,1,1,1,1,   -- 6s.
                   1,1,1,1,1, 1,1,1,1,1,   -- 7s.
                   1,1,1,1,1, 1,1,1,1,1,   -- 8s. 
                   1,1,0,0,1, 1,1,1,1,1,   -- 9s.
                   1,1,1,1,1, 1,1,1,1,1,   -- 10s.
                   1,1,1,0,1, 1,1,1,1,1,   -- 11s. 
                   1,1,1,1,1, 1,1,1,1,1,   -- 12s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 13s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 14s. 
                   0,0,0,0,0, 0,0,0,0,0,   -- 15s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 16s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 17s.
                   1,1,1,1,1, 1,1,1,1,1,   -- 18s. 
                   1,1,1,1,1, 1,1,1,1,1,   -- 19s.
                   1,1,1,1,1, 1,1,1,1,1);  -- 20s.                   
    ---------------------------------------------------------------------
    ------ PILOT'S BUTTON -----------------------------------------------

    cantidad_datos_PilotButton: constant := 200;
    type Indice_Secuencia_PilotButton is mod cantidad_datos_PilotButton;
    type tipo_Secuencia_PilotButton is array (Indice_Secuencia_PilotButton) of PilotButton_Samples_Type;

    PilotButton_Simulation: tipo_Secuencia_PilotButton :=  -- 1 muestra cada 100ms.
                 ( 0,0,0,0,0, 0,0,0,0,0,   -- 1s. 
                   0,0,0,0,0, 1,1,1,0,0,   -- 2s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 3s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 4s. 
                   1,1,1,1,0, 0,0,0,0,0,   -- 5s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 6s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 7s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 8s. 
                   0,0,0,0,0, 0,0,0,0,0,   -- 9s.
                   0,0,0,0,0, 0,0,0,0,0,  -- 10s.                   
                   0,0,0,0,0, 0,0,0,0,0,   -- 11s. 
                   0,0,0,0,0, 1,1,1,1,1,   -- 12s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 13s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 14s. 
                   0,0,0,0,0, 0,0,0,0,0,   -- 15s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 16s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 17s.
                   0,0,0,0,0, 0,0,0,0,0,   -- 18s. 
                   0,0,0,0,0, 0,0,0,0,0,   -- 19s.
                   0,0,0,0,0, 0,0,0,0,0);  -- 20s.
end Scenario_V2;



