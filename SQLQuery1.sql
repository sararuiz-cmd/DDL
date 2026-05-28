/*
Crear una base de datos llamada UniversidadDB la cual maneja dos modulos: Academico y seguridad
Modulo academico: Carrera y Estudiante
Modulo seguridad: Cargo y Usuario
*/
use master
go
if exists(select * from sys.databases where name = 'UniversidadDB')
begin
	drop database UniversidadDB
end
go
create database UniversidadDB
go
--Schema: Es un contenedor logico que sirve para organizar objetos dentro de una base de datos.
create schema Academico
go
create schema Seguridad
go
create table Academico.Carrera(
	id int primary key identity(1,1),
	nombre nvarchar(100) not null,
	precio decimal(10,2),
	created_at datetime default sysdatetime(),
	updated_at datetime 


