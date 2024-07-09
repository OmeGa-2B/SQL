update personas
	set fecha_nacimiento = '1993-4-28'
	where fecha_nacimiento is null
select * from personas



--Muestra la fecha actual.
select current_timestamp;

--¿Qué fecha será dentro de una semana?
select current_timestamp + interval '7 days';

--¿Cuál es la edad solo en años de las personas?.
select nombre,primerapellido,segundoapellido, DATE_PART('year', AGE(current_date,fecha_nacimiento)) as edad
from personas;

--Muestra en columnas separadas al año, mes, día de la fecha de nacimiento de cada persona, en donde cada columna tenga un nombre que referencie el contenido.
select nombre,primerapellido,segundoapellido,
	extract(year from fecha_nacimiento) as año_nacimiento,
	extract(month from fecha_nacimiento) as mes_nacimiento,
	extract(day from fecha_nacimiento) as dia_nacimiento
from personas;

--Muestra " el día de hoy [11/03/2010] es [Saturday] ". Donde lo que está en corchete se obtenga por comando SQL y no por texto.
select concat('el dia de hoy ',' ',current_date,' ','es',' ',to_char(current_date,'DAY'))

--Muestra " [Roberto Alvarado] se nació el [sábado] [11/03/2010] ". Donde lo que está en corchete se obtenga por comando SQL y no por texto.
select concat(nombre,' ',primerapellido,' ','nacio el ',' ',to_char(current_date,'DAY'),' ',current_date) from personas

--Muestra a las personas que nacieron en el 2010.
update personas
	set fecha_nacimiento = '2010-09-17'
	where id_persona = 13
select * from personas where extract(year from fecha_nacimiento) = '2010'

--Muestra a los que nacieron en diciembre de cualquier año.
update personas
	set fecha_nacimiento = '2002-12-17'
	where id_persona = 25
select * from personas where extract(month from fecha_nacimiento) = '12'

--Muestra a los que nacieron en febrero del 1999.
update personas
	set fecha_nacimiento = '1999-2-17'
	where id_persona = 68
select * from personas where extract(month from fecha_nacimiento) = '2' and extract(year from fecha_nacimiento) = '1999'

--Muestra a las personas que tienen menos de 6 meses que cumplieron añosSELECT * FROM personas 
SELECT * FROM personas 
WHERE 
  (
    (EXTRACT(MONTH FROM CURRENT_DATE) - EXTRACT(MONTH FROM fecha_nacimiento)) * 30 + 
    (EXTRACT(DAY FROM CURRENT_DATE) - EXTRACT(DAY FROM fecha_nacimiento))
  ) BETWEEN 0 AND 180;


-- Muestra a las personas que tienen menos de 30 años.
select * from personas where DATE_PART('year', AGE(current_date,fecha_nacimiento)) < 30

--Muestra a las personas que hoy cumplen años.

update personas
	set fecha_nacimiento = '2002-5-31'
	where id_persona = 112
	
select * from personas where EXTRACT(DAY FROM CURRENT_DATE) = extract(day from fecha_nacimiento)
		and extract(month from current_date) = extract(month from fecha_nacimiento)

--Muestra a las personas que cumplen años Enero Febrero, Marzo o Abril.
select * from personas where
	extract(month from fecha_nacimiento) = 1 or
	extract(month from fecha_nacimiento) = 2 or
	extract(month from fecha_nacimiento) = 3 or
	extract(month from fecha_nacimiento) = 4
	
--Las personas cuya edad este entre 20 y 40 años
select * from personas
	where DATE_PART('year', AGE(current_date,fecha_nacimiento)) > 19 and
	DATE_PART('year', AGE(current_date,fecha_nacimiento)) < 41

--Las personas mayores de 40 años.

update personas
	set fecha_nacimiento = '1963-5-31'
	where id_persona = 141
	
select * from personas
	where DATE_PART('year', AGE(current_date,fecha_nacimiento)) > 40

--Las personas menores de 25 años.

select * from personas
	where DATE_PART('year', AGE(current_date,fecha_nacimiento)) < 25
	
-- personas mes de marzo, octube y agosto
select * from personas where
	extract(month from fecha_nacimiento) = 3 or
	extract(month from fecha_nacimiento) = 8 or
	extract(month from fecha_nacimiento) = 10