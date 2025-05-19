

--Crear el procedimiento almacenado pa_registrarTrabajadorActividad

go
create function fn_Personal (@idtrabajador int)
returns int
as
begin

declare @resultado int

set @resultado = (select isnull(count(*), 0) from personal p inner join Trabajar t
					on t.idTrabajador = p.idTrabajador
					where p.idTrabajador = @idtrabajador	
					and t.fecBaja is null)

return @resultado

end

go
create function fn_Actividad (@idactividad int)
returns int
as
begin

declare @resultado int

set @resultado = (select isnull(count(*), 0) from Actividades where idActividad = @idactividad)

return @resultado

end

go
create function fn_getDia (@numDia int)
returns nvarchar(9)
as
BEGIN

declare @nombreDia nvarchar(9)

if (@numDia not between 1 and 7)
	return 'No válido'

begin
    CASE
        WHEN @numDia = 1 THEN set @nombreDia = 'Lunes'
        WHEN @numDia = 2 THEN set @nombreDia = 'Martes'
        WHEN @numDia = 3 THEN set @nombreDia = 'Miércoles'
        WHEN @numDia = 4 THEN set @nombreDia = 'Jueves'
        WHEN @numDia = 5 THEN set @nombreDia = 'Viernes'
        WHEN @numDia = 6 THEN set @nombreDia = 'Sábado'
        WHEN @numDia = 7 THEN set @nombreDia = 'Domingo'
    END
end
	
return @nombreDia
	
END

																																																																																																																																																																												
go
create procedure pa_registrarTrabajadorActividad
@idtrabajador int, @idactividad int
as
begin

begin try

if (dbo.fn_Personal(@idtrabajador) = 0)
		RAISERROR('El trabajador no existe.', 16, 1);

if (dbo.fn_Actividad(@idactividad) = 0)
		RAISERROR('La actividad no existe.', 16, 1);


declare @alojTrabajador int, @dia nvarchar(9)

select @alojTrabajador = idalojamiento from Trabajar where idTrabajador = @idtrabajador

insert into Organizar (@alojTrabajador, @idactividad, )



end try begin catch


end catch

end
