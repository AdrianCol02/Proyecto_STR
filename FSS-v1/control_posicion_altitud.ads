with Ada.Real_Time; use Ada.Real_Time;
with devicesFSS_V1; use devicesFSS_V1;

package control_posicion_altitud is

    task control_pitch is
        entry Set_Aircraft_Pitch(pitch: in Pitch_Samples_Type);
    end control_pitch;
    task control_roll is
        entry Read_Roll;
    end control_roll;
    task control_altitude;

end control_posicion_altitud;