--Muestre solo a las personas que son Alumnos.
SELECT * FROM personas WHERE id_persona IN (SELECT id_persona FROM estudiantes);

--Muestre solo a las personas que son Docentes.
select * from personas where id_persona in (select id_persona from docente);

--Muestre el/los grupos de cada docente.
SELECT *, 
       (SELECT STRING_AGG(grupo, ', ')
        FROM grupos
        WHERE docente.id_docente = grupos.id_profesor) AS grupos
FROM docente;

--¿Que alumno o alumnos han reprobado?
select * ,(select avg(calificacion)
				 from estudiante_materia where 
				 id_boleta = boleta) 
					 from estudiantes where (select avg(calificacion)
				 		from estudiante_materia where 
				 		id_boleta = boleta) <6

--¿Que materia tiene cada carrera?

select * ,(select avg(calificacion)
				 from estudiante_materia where 
				 id_boleta = boleta) from estudiantes
				 
--¿Que materias se imparten a las 10:00 pm?
SELECT nombre_materia, 
       (SELECT hora_inicio 
        FROM horarios 
        WHERE horarios.id_materia = materia.id_materia 
          AND hora_inicio = '22:00') AS hora_inicio
FROM materia
WHERE id_materia IN 
      (SELECT id_materia 
       FROM horarios 
       WHERE hora_inicio = '22:00');

--¿Que carreras se imparten en que plantel?
select *, (SELECT STRING_AGG(clave_plantel, ', ')
        FROM plantel
        WHERE carrera.id_plantel = plantel.id_plantel) as plantel from carrera
		
--Muestre el horario de cada laboratorio
SELECT horarios.*,
       aula.nombre_aula,
       aula.tipo
FROM horarios
JOIN aula ON aula.id_aula = horarios.id_aula AND aula.tipo = 'Laboratorio'
WHERE EXISTS (
    SELECT 1 
    FROM aula 
    WHERE aula.id_aula = horarios.id_aula 
      AND aula.tipo = 'Laboratorio'
)


--¿En que delegacion/municipio  existen mas docentes?
SELECT delegacion_municipio, COUNT(*) AS num_profesores FROM personas
	WHERE id_persona IN (SELECT id_persona FROM docente)
	GROUP BY delegacion_municipio
	ORDER BY num_profesores DESC;

