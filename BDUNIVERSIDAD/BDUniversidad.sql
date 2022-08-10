--Base de datos Ejemplo
--Durand Castro 
--08/08/22

use master 
go

if DB_ID('BDUniversidad') is not null
	drop database BDUniversidad
go

Create Database BDUniversidad
go

use BDUniversidad
go

--CREAR TABLAS
if OBJECT_ID('TEscuela') is not null
	drop table TEscuela
go

CREATE TABLE TEscuela(
CodEscuela CHAR (3) PRIMARY KEY,
Escuela VARCHAR (50),
Facultad VARCHAR (50)
)
go

if OBJECT_ID('TAlumno') is not null
	drop table TAlumno
go

CREATE TABLE TAlumno(
codAlumno CHAR(5) PRIMARY KEY,
Apellidos VARCHAR (50),
Nombres VARCHAR (50),
LugarNac VARCHAR (50),
FeachaNac datetime,
CodEscuela CHAR (3) FOREIGN KEY REFERENCES TEscuela(CodEscuela)
)
GO

--Insercion de datos
INSERT INTO TEscuela VALUES ('E01', 'SISTEMAS', 'INGENIERIA')
INSERT INTO TEscuela VALUES ('E02', 'CIVIL', 'INGENIERIA')
INSERT INTO TEscuela VALUES ('E03', 'INDUSTRIAL', 'INGENIERIA')
INSERT INTO TEscuela VALUES ('E04', 'AMBIENTAL', 'INGENIERIA')
INSERT INTO TEscuela VALUES ('E05', 'ARQUITECTURA', 'INGENIERIA')


SELECT * FROM TEscuela

SELECT * FROM TAlumno