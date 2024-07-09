
--	*Muestra el nombre completo, boleta, materia y horario de los estudiantes

SELECT p.nombre, p.primerapellido, p.segundoapellido, es.boleta, m.nombre_materia, h.hora_inicio,h.hora_fin 
FROM personas AS p
	inner join estudiantes AS es ON p.id_persona = es.id_persona
	inner join estudiante_materia as em on es.boleta = em.id_boleta
	inner join horarios as h on em.id_materia = h.id_materia
	inner join materia as m on h.id_materia = m.id_materia

--	*Muestra el nombre completo, grado academico y materia que imparten los docentes.
select p.nombre, p.primerapellido, p.segundoapellido,d.grado_academico,m.nombre_materia
from personas as p
	inner join docente as d on p.id_persona = d.id_persona
	inner join grupos as g on d.id_docente = g.id_profesor
	inner join materia as m on g.id_materia = m.id_materia

select * from materia
--	*Muestra el nombre y la boleta de los estudiantes con materias en maestria

select p.nombre, p.primerapellido, p.segundoapellido, es.boleta, m.nombre_materia,c.nombre_carrera
from personas as p 
	inner join estudiantes as es on p.id_persona = es.id_persona
	inner join estudiante_materia as em on es.boleta = em.id_boleta
	inner join materia as m on em.id_materia = m.id_materia
	inner join carrera as c on m.id_carrera = c.id_carrera
		where m.id_carrera in(6,7,12,19,13,4,21,20,25,8)
	
	
--	*Muestra la boleta y el nombre de los estudiantes indicando en que materias reprobaron.

SELECT p.nombre, p.primerapellido, p.segundoapellido, es.boleta, m.nombre_materia, em.calificacion
FROM personas AS p
	inner join estudiantes AS es ON p.id_persona = es.id_persona
	inner join estudiante_materia as em on es.boleta = em.id_boleta
	inner join materia as m on em.id_materia = m.id_materia
		where em.calificacion < 6
	
--	*Muestra las carreras y materias que se imparten en cada plantel
select m.nombre_materia,c.nombre_carrera,p.nombre_plantel
from materia as m
	inner join carrera as c on m.id_carrera = c.id_carrera
	inner join plantel as p on c.id_plantel = p.id_plantel

select * from plantel
insert into plantel(nombre_plantel,clave_plantel) values
	('Escuela Superior de Mediciona','ESM')
--	*¿Que planteles aun no tienen una carrera asignada?
SELECT p.nombre_plantel
FROM plantel AS p
	LEFT JOIN carrera AS c ON p.id_plantel = c.id_plantel
	WHERE c.id_carrera IS NULL;


--	*Indica en que aulas y carreras se imparten las materias de Bases de Datos
select m.nombre_materia, c.nombre_carrera, a.nombre_aula
from carrera as c
	inner join materia as m on c.id_carrera = m.id_carrera
	inner join horarios as h on m.id_materia = h.id_materia
	inner join aula as a on h.id_aula = a.id_aula
		where m.nombre_materia = 'Bases de Datos'

--	*Muestra los grupos y el horario que tienen

select g.grupo, h.hora_inicio, h.hora_fin
from horarios as h
	inner join materia as m on h.id_materia = m.id_materia
	inner join grupos as g on m.id_materia = g.id_materia

--	*Muestra las delegaciones con mas de 2 personas y señale que son (Docente/Alumno).
-- Subconsulta para obtener delegaciones con más de 2 personas

-- Consulta principal para mostrar los registros individuales

WITH delegaciones_con_mas_de_dos_personas AS (
    SELECT p.delegacion_municipio
    FROM personas AS p
    LEFT JOIN docente AS d ON p.id_persona = d.id_persona
    LEFT JOIN estudiantes AS e ON p.id_persona = e.id_persona
    GROUP BY p.delegacion_municipio
    HAVING COUNT(p.id_persona) > 2
)

SELECT 
    p.nombre, p.primerapellido, p.segundoapellido, p.delegacion_municipio,
    CASE 
        WHEN d.id_persona IS NOT NULL THEN 'Docente'
        WHEN e.id_persona IS NOT NULL THEN 'Alumno'
    END AS tipo_persona
FROM 
    personas AS p
LEFT JOIN 
    docente AS d ON p.id_persona = d.id_persona
LEFT JOIN 
    estudiantes AS e ON p.id_persona = e.id_persona
WHERE 
    p.delegacion_municipio IN (SELECT delegacion_municipio FROM delegaciones_con_mas_de_dos_personas);


--	*Muestra la boleta y nombre del alumno que toma mas de 3 materias
select p.nombre,p.primerapellido,p.segundoapellido,em.id_boleta, count(em.id_materia) as numero_materias
from estudiante_materia as em
	inner join estudiantes as e on em.id_boleta = e.boleta
	inner join personas as p on e.id_persona = p.id_persona
	group by p.nombre, p.primerapellido, p.segundoapellido,em.id_boleta
	having count(em.id_materia) > 3
	
	
	
-- nombre de los alumnos, carrera
select distinct p.nombre,p.primerapellido,p.segundoapellido,e.boleta, c.nombre_carrera
from personas as p
inner join estudiantes as e on p.id_persona = e.id_persona
inner join estudiante_materia as em on e.boleta = em.id_boleta
inner join materia as m on em.id_materia = m.id_materia
inner join carrera as c on m.id_carrera = c.id_carrera