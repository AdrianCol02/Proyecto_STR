package body Datos_Aeronave is
    Datos_Internos : Datos_Type; -- Datos almacenados

    procedure Actualizar_Datos(Nuevos_Datos : Datos_Type) is
    begin
        Datos_Internos := Nuevos_Datos; -- Actualizar los datos internos
    end Actualizar_Datos;

    procedure Leer_Datos(Datos : out Datos_Type) is
    begin
        Datos := Datos_Internos; -- Leer los datos internos
    end Leer_Datos;
end Datos_Aeronave;