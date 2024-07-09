
--*Muestra el total de docentes por plantel

select count(d.id_docente) as Num_docentes,pl.nombre_plantel
 from docente as d
inner join grupos as g on d.id_docente  = g.id_profesor
inner join materia as m on g.id_materia = m.id_materia
inner join carrera as c on m.id_carrera = c.id_carrera
inner join plantel as pl on c.id_plantel = pl.id_plantel
group by pl.nombre_plantel;

--*¿Cuántas personas estan registradas de Gustavo A. Madero o Azcapotzalco tenemos?

select delegacion_municipio,count(*) as num_personas
from personas
	where delegacion_municipio in('Gustavo A. Madero','Azcapotzalco')
group by delegacion_municipio
--*¿Cual es el promedio por delegacion de los alumnos?
SELECT p.delegacion_municipio,avg(em.calificacion) AS promedio_calificaciones
FROM  estudiantes e
INNER JOIN personas p on e.id_persona = p.id_persona
inner join estudiante_materia em on e.boleta = em.id_boleta
group by p.delegacion_municipio

--*¿Cuántos docentes tenemos de cada grado academico?
select grado_academico,count(*)
from docente
group by grado_academico

--*¿Cuántos docentes tenemos por carrera tenemos?

select count(d.id_docente) as Num_docentes,c.nombre_carrera
 from docente as d
inner join grupos as g on d.id_docente  = g.id_profesor
inner join materia as m on g.id_materia = m.id_materia
inner join carrera as c on m.id_carrera = c.id_carrera
group by c.nombre_carrera;

--*Muestra el total de personas dados de alta por delegacion
select delegacion_municipio,count(*) as num_personas
from personas
group by delegacion_municipio
--*Muestra el total de docentes por materia

select count(d.id_docente) as Num_docentes,m.nombre_materia
 from docente as d
inner join grupos as g on d.id_docente  = g.id_profesor
inner join materia as m on g.id_materia = m.id_materia
group by m.nombre_materia

--*Muestra el promedio mas alto, el promedio bajo y el promedio general de los alumnos.
select max(promedio) as promedio_mas_alto,
	   min(promedio) as promedio_mas_bajo,
	   avg(promedio) as promedio_general
from(
	select avg(em.calificacion) as promedio
	from estudiantes e
	inner join estudiante_materia em on e.boleta = em.id_boleta
	group by e.boleta) as promedios_alumnos
	
	
/*Se desea un reporte del total de las personas que nacieron en cada año, pero solo para los años en los
	que nacieron 3 o mas personas, de la siguiente forma:  
 
   Año Nacimiento |  Total Personas
     1980             |    3
     1984             |    5
*/
select extract(year from fecha_nacimiento) as anio_nacimiento, count(*) as total_personas
from personas
group by extract(year from fecha_nacimiento)
having count(*) >= 3
order by anio_nacimiento


/*Genera el siguiente reporte, toma en consideracion este ejemplo:
      Delegación      | #Alumnos   | Promedio Edad  | #Docentes |Promedio Edad
        Azcapotzalco  |     5      |      21        |     2     |     41
        Iztapalapa    |     2      |      30        |     6     |    31
*/

select p.delegacion_municipio,
	count(case when e.id_persona = p.id_persona then 1 else null end) as num_alumnos,
	round(avg(extract(year from age(current_date,p.fecha_nacimiento))),2) as promedio_edad,
	count(case when d.id_persona = p.id_persona then 1 else null end) as num_docentes,
	round(avg(extract(year from age(current_date,p.fecha_nacimiento))),2) as promedio_edad
from personas p
left join estudiantes e on p.id_persona = e.id_persona
left join docente d on p.id_persona = d.id_persona
group by p.delegacion_municipio

	
	

-- 10 apellidos mas populares

WITH count_pa AS (
  SELECT p.primerapellido, COUNT(*) AS num_pa
  FROM personas p
  WHERE p.primerapellido IS NOT NULL  -- Filtrar valores nulos
  GROUP BY p.primerapellido
  ORDER BY num_pa DESC
  LIMIT 10
),
count_sa AS (
  SELECT p.segundoapellido, COUNT(*) AS num_sa
  FROM personas p
  WHERE p.segundoapellido IS NOT NULL  -- Filtrar valores nulos
  GROUP BY p.segundoapellido
  ORDER BY num_sa DESC
  LIMIT 10
),
ranked_pa AS (
  SELECT ROW_NUMBER() OVER (ORDER BY num_pa DESC) AS rank, primerapellido, num_pa
  FROM count_pa
),
ranked_sa AS (
  SELECT ROW_NUMBER() OVER (ORDER BY num_sa DESC) AS rank, segundoapellido, num_sa
  FROM count_sa
)
SELECT 
  COALESCE(ranked_pa.primerapellido, '') AS primerapellido,  -- Manejar campos nulos con COALESCE
  ranked_pa.num_pa, 
  COALESCE(ranked_sa.segundoapellido, '') AS segundoapellido,  -- Manejar campos nulos con COALESCE
  ranked_sa.num_sa
FROM ranked_pa
FULL OUTER JOIN ranked_sa
ON ranked_pa.rank = ranked_sa.rank
ORDER BY ranked_pa.rank;


