-- 1-20 un numero
update personas
	 set telefono = '5509034903'
where id_persona between 1 and 20
-- 21-40 un numero
update personas
	set  telefono = '7863740927'
where id_persona between 21 and 40
--15-60 un email
update personas
	set correo = 'personaN@gmail.com'
where id_persona  between 15 and 60
--130-141 sin primerapellido
ALTER TABLE personas
	ALTER COLUMN primerapellido DROP NOT NULL;

update personas
	 set primerapellido = null
where id_persona between 130 and 141
-- is null
select * from personas

-- Muestra las personas que todavía no tienen un teléfono asignado.
select * from personas where telefono is null;
--Muestra las personas que tienen un correo asignado.
select * from personas where correo is not null;
-- Muestra el nombre de las materias que aun no tienen un semestre.
insert into materia(creditos,id_carrera,clave,nombre_materia) values
	('10','1','DW', 'Desarollo Web')
select nombre_materia from materia where semestre is null;
--Muestra las materias con una academia asignada
select * from materia where academia is not null;
--Muestra las carreras que aun no tienen una clave.
insert into carrera(id_plantel,nombre_carrera) values
	(10, 'Matematicas Aplicadas y Computacion')
select * from carrera where clave_carrera is null;
--Muestra las personas con primer apellido no asignado.
select * from personas where primerapellido is null;

--personas sin telefono, corre pero sin tegan segundo apellido
select * from personas where 
	correo is null
	and telefono is null
	and segundoapellido is not null;



