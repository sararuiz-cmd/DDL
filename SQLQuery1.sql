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
CREATE DATABASE UniversidadDB;
GO
use UniversidadDB
go

--Schema: Es un contenedor logico que sirve para organizar objetos dentro de una base de datos.
create schema Academico
go
create schema Seguridad
go
create table Academico.Carrera(
	id_carrera int identity(1,1) primary key ,
	nombre nvarchar(100) not null,
	precio decimal(10,2),
	created_at datetime default getdate(),
	updated_at datetime null,
	deleted_at datetime null,
	Constraint ck_carrera check (precio>0)
)
go
create table Academico.Estudiante(
	id_estudiante int identity(1,1) primary key
	, cif varchar(8) unique not null
	, nombres nvarchar(60) not null
	, apellidos nvarchar(60) not null
	, fechaNac datetime null
	, email nvarchar(120)not null
	, id_carrera int not null
	, created_at datetime default getdate(),
	updated_at datetime null,
	deleted_at datetime null,
	constraint uq_cif unique (cif),
	constraint uq_email unique(email),
	constraint ck_email check(email like '%_@_%._%'),
	constraint fk_estudiante_carrera foreign key (id_carrera) references Academico.carrera(id_carrera)
	on delete no action on update cascade
	
	
)
go

create table Seguridad.Cargo(
    id_cargo INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,

    CONSTRAINT uq_cargo_nombre UNIQUE (nombre)
);
GO
create table Seguridad.Usuario(
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    cif VARCHAR(8) NOT NULL,
    nombres NVARCHAR(60) NOT NULL,
    apellidos NVARCHAR(60) NOT NULL,
    fechaNac DATETIME NULL,
    pw VARBINARY(64) NOT NULL,
    email NVARCHAR(120) NOT NULL,
    id_cargo INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,

    CONSTRAINT uq_usuario_cif UNIQUE (cif),
    CONSTRAINT uq_usuario_email UNIQUE (email),
    CONSTRAINT ck_usuario_email CHECK (email LIKE '%_@_%._%'),

    CONSTRAINT fk_usuario_cargo
        FOREIGN KEY (id_cargo)
        REFERENCES Seguridad.Cargo(id_cargo)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
GO

--Insert
insert into Academico.Carrera(nombre,precio)
values('Sistemas',2000)
update Academico.Carrera set precio=2000.99, updated_at=GETDATE() where id=1
insert into Seguridad.Usuario(cif,nombres,apellidos,pw)values('401','Juan','Lopez',HASHBYTES('Sha2_256','Temp2026'))
select * from Seguridad.Usuario