--creacion tablas intermedias

-- plantel_carrera

create table plantel_carrera(
	id_carrera integer,
	id_plantel integer
);

alter table plantel_carrera add constraint "fk_id_plantel_plantel_carrera" 
	foreign key (id_plantel) references Plantel(id_plantel)

alter table plantel_carrera add constraint "fk_id_carrera_plantel_carrera" 
	foreign key (id_carrera) references Carrera(id_carrera)

insert into plantel_carrera
	select id_carrera,id_plantel from carrera

update plantel_carrera
	set id_carrera = 1
	where id_carrera = 27;

update plantel_carrera
	set id_carrera = 2
	where id_carrera = 31;

update plantel_carrera
	set id_carrera = 3
	where id_carrera in(28,32);

update plantel_carrera
	set id_carrera = 9
	where id_carrera = 16;

update plantel_carrera
	set id_carrera = 22
	where id_carrera in(23,30);

update plantel_carrera
	set id_carrera = 11
	where id_carrera = 18;
-- update tabla carrera
alter table materia drop constraint id_carrera_fk;
alter table carrera drop column id_plantel;

delete from carrera where id_carrera = 27;
delete from carrera where id_carrera = 31;
delete from carrera where id_carrera in(28,32);
delete from carrera where id_carrera = 16;
delete from carrera where id_carrera in(23,30);
delete from carrera where id_carrera = 18;

-- carrera_materia-----------------------------------------------------------------
create table carrera_materia(
	id_materia integer,
	id_carrera integer
);

alter table carrera_materia add constraint "fk_id_carrera_carrera_materia" 
	foreign key (id_carrera) references Carrera(id_carrera)

alter table carrera_materia add constraint "fk_id_materia_carrera_materia" 
	foreign key (id_materia) references Materia(id_materia)
	
insert into carrera_materia
	select id_materia, id_carrera from materia

select * from carrera_materia where id_carrera = '3'
select * from materia
	where clave = 'MDD'
	--order by clave
	
	--updates id_carrera
update carrera_materia
	set id_carrera = 1
	where id_carrera = 27;
	
update carrera_materia
	set id_carrera = 2
	where id_carrera = 31;

update carrera_materia
	set id_carrera = 3
	where id_carrera in(28,32);

update carrera_materia
	set id_carrera = 9
	where id_carrera = 16;

update carrera_materia
	set id_carrera = 22
	where id_carrera in(23,30);
	
update carrera_materia
	set id_carrera = 11
	where id_carrera = 18;
	
	-- updates id_materia
select * from materia order by clave

update carrera_materia
	set id_materia = 3
	where id_materia IN(8,14,27,33,37,40);
	
update carrera_materia
	set id_materia = 2
	where id_materia = 26;

update carrera_materia
	set id_materia = 13
	where id_materia IN(32,36);

update carrera_materia
	set id_materia = 1
	where id_materia IN(7,12,25,31,35,39);
	
update carrera_materia
	set id_materia = 4
	where id_materia = 28;

update carrera_materia
	set id_materia = 10
	where id_materia = 42;

update carrera_materia
	set id_materia = 5
	where id_materia IN(9,29,41);

update carrera_materia
	set id_materia = 6
	where id_materia IN(11,15,30,34,38,43);
-- eliminacion de registros repetidos sin id

CREATE TEMP TABLE tabla_eliminacion AS
	SELECT DISTINCT id_materia, id_carrera
	FROM carrera_materia;
	
delete from carrera_materia;
insert into carrera_materia select * from tabla_eliminacion;
-- update tabla materia --

alter table materia drop column id_carrera;

delete from materia where id_materia in(37,40,8,27,33,14);
delete from materia where id_materia = 26;
delete from materia where id_materia in(36,32);
delete from materia where id_materia in(35,31,7,12,39,25);
delete from materia where id_materia in(28,42);
delete from materia where id_materia in(29,9,41);
delete from materia where id_materia in(34,11,43,30,38,15);

-- grupos ------------------------------------------------------------------------

update grupos
	set id_materia = 3
	where id_materia IN(8,14,27,33,37,40);
	
update grupos
	set id_materia = 2
	where id_materia = 26;

update grupos
	set id_materia = 13
	where id_materia IN(32,36);

update grupos
	set id_materia = 1
	where id_materia IN(7,12,25,31,35,39);

update grupos
	set id_materia = 10
	where id_materia = 42;

update grupos
	set id_materia = 4
	where id_materia =28;

update grupos
	set id_materia = 5
	where id_materia IN(9,29,41);

update grupos
	set id_materia = 6
	where id_materia IN(11,15,30,34,38,43);
--estudiante_materia-------------------------------------------------

update estudiante_materia
	set id_materia = 3
	where id_materia IN(8,14,27,33,37,40);

update estudiante_materia
	set id_materia = 2
	where id_materia = 26;

update estudiante_materia
	set id_materia = 13
	where id_materia IN(32,36);

update estudiante_materia
	set id_materia = 1
	where id_materia IN(7,12,25,31,35,39);
	
update estudiante_materia
	set id_materia = 4
	where id_materia =28;

update estudiante_materia
	set id_materia = 10
	where id_materia =42;

update estudiante_materia
	set id_materia = 5
	where id_materia IN(9,29,41);

update estudiante_materia
	set id_materia = 6
	where id_materia IN(11,15,30,34,38,43);
--aula_horario--------------------------------------------------------
create table aula_horario(
	id_aula integer,
	id_horario integer
);

alter table aula_horario add constraint "fk_id_aula_aula_horario" 
	foreign key (id_aula) references aula(id_aula);
	
alter table aula_horario add constraint "fk_id_horario_aula_horario" 
	foreign key (id_horario) references horarios(id_horario);
	
insert into aula_horario
	select id_aula, id_horario from horarios;
	
--updates

--lunes
update aula_horario
	set id_horario = 7
	where id_horario IN(31,55,79,103,127);

update aula_horario
	set id_horario = 10
	where id_horario IN(34,58,82,106,130);

update aula_horario
	set id_horario = 16
	where id_horario IN(40,64,88,112,136);

update aula_horario
	set id_horario = 19
	where id_horario IN(43,67,91,115);
	
update aula_horario
	set id_horario = 22
	where id_horario IN(46,70,94,118);

update aula_horario
	set id_horario = 13
	where id_horario IN(37,61,85,109,133);

update aula_horario
	set id_horario = 1
	where id_horario IN(25,49,73,97,121);

update aula_horario
	set id_horario = 4
	where id_horario IN(28,52,76,100,124);
	
--martes
update aula_horario
	set id_horario = 35
	where id_horario = 107;

update aula_horario
	set id_horario = 32
	where id_horario = 104;

update aula_horario
	set id_horario = 44
	where id_horario = 116;

update aula_horario
	set id_horario = 47
	where id_horario = 119;

update aula_horario
	set id_horario = 38
	where id_horario = 110;

update aula_horario
	set id_horario = 26
	where id_horario = 98;

update aula_horario
	set id_horario = 29
	where id_horario = 101;

--miercoles 


update aula_horario
	set id_horario = 8
	where id_horario in(80,128);

update aula_horario
	set id_horario = 11
	where id_horario in(83,131);

update aula_horario
	set id_horario = 17
	where id_horario in(137,41,89,113);

update aula_horario
	set id_horario = 20
	where id_horario = 92;

update aula_horario
	set id_horario = 23
	where id_horario = 95;

update aula_horario
	set id_horario = 14
	where id_horario in(134,86);

update aula_horario
	set id_horario = 2
	where id_horario in(122,74);

update aula_horario
	set id_horario = 5
	where id_horario in(77,125);

--jueves
update aula_horario
	set id_horario = 9
	where id_horario in(56,129,105,81,33);

update aula_horario
	set id_horario = 12
	where id_horario in(59,132,84,36,108);

update aula_horario
	set id_horario = 18
	where id_horario in(42,65,90,114,138);

update aula_horario
	set id_horario = 21
	where id_horario in(68,45,93,117);

update aula_horario
	set id_horario = 24
	where id_horario in(120,48,96,71);

update aula_horario
	set id_horario = 15
	where id_horario in(135,39,62,87,111);

update aula_horario
	set id_horario = 3
	where id_horario in(99,75,27,123,50);

update aula_horario
	set id_horario = 6
	where id_horario in(53,126,78,30,102);
	
-- materia_horario ----------------------------------------------------

create table materia_horario(
	id_horario integer,
	id_materia integer
);

alter table materia_horario add constraint "fk_id_horario_materia_horario" 
	foreign key (id_horario) references horarios(id_horario);
	
alter table materia_horario add constraint "fk_id_materia_materia_horario" 
	foreign key (id_materia) references materia(id_materia);
	
insert into materia_horario
	select id_horario, id_materia from horarios;
	


-- updates id_materia
update materia_horario
	set id_materia = 3
	where id_materia IN(8,14,27,33,37,40);
	
update materia_horario
	set id_materia = 2
	where id_materia = 26;

update materia_horario
	set id_materia = 13
	where id_materia IN(32,36);

update materia_horario
	set id_materia = 1
	where id_materia IN(7,12,25,31,35,39);

update materia_horario
	set id_materia = 4
	where id_materia = 28;
	
update materia_horario
	set id_materia = 10
	where id_materia = 42;
	
update materia_horario
	set id_materia = 5
	where id_materia IN(9,29,41);

update materia_horario
	set id_materia = 6
	where id_materia IN(11,15,30,34,38,43);
	

--lunes
update materia_horario
	set id_horario = 7
	where id_horario IN(31,55,79,103,127);

update materia_horario
	set id_horario = 10
	where id_horario IN(34,58,82,106,130);

update materia_horario
	set id_horario = 16
	where id_horario IN(40,64,88,112,136);

update materia_horario
	set id_horario = 19
	where id_horario IN(43,67,91,115);
	
update materia_horario
	set id_horario = 22
	where id_horario IN(46,70,94,118);

update materia_horario
	set id_horario = 13
	where id_horario IN(37,61,85,109,133);

update materia_horario
	set id_horario = 1
	where id_horario IN(25,49,73,97,121);

update materia_horario
	set id_horario = 4
	where id_horario IN(28,52,76,100,124);
	
--martes

update materia_horario
	set id_horario = 35
	where id_horario = 107;

update materia_horario
	set id_horario = 32
	where id_horario = 104;

update materia_horario
	set id_horario = 44
	where id_horario = 116;

update materia_horario
	set id_horario = 47
	where id_horario = 119;

update materia_horario
	set id_horario = 38
	where id_horario = 110;

update materia_horario
	set id_horario = 26
	where id_horario = 98;

update materia_horario
	set id_horario = 29
	where id_horario = 101;

--miercoles 

update materia_horario
	set id_horario = 8
	where id_horario in(80,128);

update materia_horario
	set id_horario = 11
	where id_horario in(83,131);

update materia_horario
	set id_horario = 17
	where id_horario in(137,41,89,113);

update materia_horario
	set id_horario = 20
	where id_horario = 92;

update materia_horario
	set id_horario = 23
	where id_horario = 95;

update materia_horario
	set id_horario = 14
	where id_horario in(134,86);

update materia_horario
	set id_horario = 2
	where id_horario in(122,74);

update materia_horario
	set id_horario = 5
	where id_horario in(77,125);

--jueves
update materia_horario
	set id_horario = 9
	where id_horario in(56,129,105,81,33);

update materia_horario
	set id_horario = 12
	where id_horario in(59,132,84,36,108);

update materia_horario
	set id_horario = 18
	where id_horario in(42,65,90,114,138);

update materia_horario
	set id_horario = 21
	where id_horario in(68,45,93,117);

update materia_horario
	set id_horario = 24
	where id_horario in(120,48,96,71);

update materia_horario
	set id_horario = 15
	where id_horario in(135,39,62,87,111);

update materia_horario
	set id_horario = 3
	where id_horario in(99,75,27,123,50);

update materia_horario
	set id_horario = 6
	where id_horario in(53,126,78,30,102);
	
CREATE TEMP TABLE tabla_eliminacion_mh AS
	SELECT DISTINCT id_horario, id_materia
	FROM materia_horario;
	
delete from materia_horario;
insert into materia_horario select * from tabla_eliminacion_mh;

-- horario--------------------------------------------------------------------------
alter table horarios drop column id_materia;
alter table horarios drop column id_aula;

--lunes
delete from horarios where id_horario in(31,55,79,103,127,34,58,82,106,130,40,64,88,112,136,43,67,91,115,46,70,94,118,37,61,85,109,133,25,49,73,97,121,28,52,76,100,124);
--martes
delete from horarios where id_horario in(104,116,119,110,98,101,107);
--miercoles
delete from horarios where id_horario in(80,128,83,131,137,41,89,113,92,95,134,86,122,74,77,125);
--jueves
delete from horarios where id_horario in(56,129,105,81,33,59,132,84,36,108,42,65,90,114,138,68,45,93,117,120,48,96,71,135,39,62,87,111,99,75,27,123,50,53,126,78,30,102);