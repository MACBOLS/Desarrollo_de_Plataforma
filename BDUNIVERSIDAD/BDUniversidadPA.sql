--PROCEDIMIENTOS ALMACENADOS
--Durand Castro 
--08/08/22

use master 
go

use BDUniversidad
go

if OBJECT_ID('spListarEscuela') is not null
	DROP PROC spListarEscuela
go

CREATE PROC spListarEscuela
AS
BEGIN 
SELECT CodEscuela, Escuela, Facultad FROM TEscuela
END
GO 

EXEC spListarEscuela
GO

if OBJECT_ID('spAgregarEscuela') is not null
	DROP PROC spAgregarEscuela
go


--PROCEDIMIENTO DE INSERCION 
CREATE PROC spAgregarEscuela
@CodEscuela CHAR (3), @Escuela VARCHAR (50), @Facultad VARCHAR (50)
AS
BEGIN 

--Se evita problemas de ralentizacion y el error que prooveemos es mas personalizado 
--Cada PA tiene errores, lo que se hace aca es personalizar los errores, enviando mensajes
--Puedes identificar mejor los errores

--CodEscuela no puede ser duplicado
IF NOT EXISTS (SELECT CodEscuela FROM TEscuela WHERE CodEscuela=@CodEscuela)
--Escuela no puede ser duplicado
IF NOT EXISTS (SELECT Escuela FROM TEscuela WHERE Escuela=@Escuela)
BEGIN
INSERT INTO TEscuela VALUES (@CodEscuela, @Escuela, @Facultad)
SELECT CodError = 0, Mensaje = 'Se inserto correctamente escuela'
END
ELSE SELECT CodError = 1, MENSAJE = 'Error: Escuela duplicado'
ELSE SELECT CodError = 1, MENSAJE = 'Error: CodEscuela duplicado'
END
GO

EXEC spAgregarEscuela "E06", "ECONOMICA", "INGENIERIA"

--ACTIVIDAD: IMPLEMENTAR ELIMINAR, ACTUALIZAR Y BUSCAR
--PRESENTAR PARA EL DIA MIERCOLES 10 DE AGOSTO A TRAVEZ DE AULA VIRTUAL 
--REALIZARLO CON EL .BAT
--busqueda sensitiva

--PROCEDIMIENTO DE ACTUALIZAR 
if OBJECT_ID('spActualizarEscuela') is not null
	drop procedure spActualizarEscuela
go

create proc spActualizarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as
begin
	--CodEscuela tiene que existir para hacer los cambios
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		--si todo esta validado pasa a ingresar datos
		begin
			update TEscuela set Escuela = @Escuela, Facultad=@Facultad
			where CodEscuela=@CodEscuela
			select CodEscuela, Escuela, Facultad from TEscuela
			where CodEscuela=@CodEscuela
			
		end
		--Si esta todo invalido pasara a dar el mensaje de error
	else select codError = 1, Mensaje = 'Error: CodEscuela no encontrada'
end
go

EXEC spActualizarEscuela "E03", "MUSICA", "ARTES"
GO

--PROCEDIMIENTO DE ELIMINIAR
if OBJECT_ID('spEliminarEscuela') is not null
	drop procedure spEliminarEscuela
go

create proc spEliminarEscuela
@CodEscuela char(3)
as
begin
	--CodEscuela no puede ser duplicado
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		--Escuela no puede ser duplicado
		--si todo esta validado pasa a ingresar datos
		begin
			delete from TEscuela where CodEscuela=@CodEscuela
			select CodEscuela, Escuela, Facultad from TEscuela
			select codError = 1, Mensaje = 'Error: La escuela fue borrada correctamente'
		end
		--Si esta todo invalido pasara a dar el mensaje de error
	else select codError = 1, Mensaje = 'Error: CodEscuela duplicado'
end
go

EXEC spEliminarEscuela "E06"
GO


--exec spEliminarEscuela "E05"
--go

--PROCEDIMIENTO DE BUSCAR
if OBJECT_ID('spBuscarEscuela') is not null
	drop procedure spBuscarEscuela
go

create proc spBuscarEscuela
@CodEscuela char(3)
as
begin
	--CodEscuela tiene que existir para hacer la busqueda
		if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		--si todo esta validado pasa a ingresar datos
			begin
				select CodEscuela, Escuela, Facultad from TEscuela
				where CodEscuela=@CodEscuela
			end
		--Si esta todo invalido pasara a dar el mensaje de error
		else select codError = 1, Mensaje = 'Error: CodEscuela no encontrada'
end
go

EXEC spBuscarEscuela "E02"
GO 


SELECT * FROM TEscuela

SELECT * FROM TAlumno
