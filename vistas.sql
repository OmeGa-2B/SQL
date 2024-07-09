CREATE VIEW vista_resumen_alumnos AS
SELECT
    CONCAT(p.nombre, ' ', p.primerapellido, ' ', p.segundoapellido) AS nombre_completo,
    COALESCE(m.nombre_materia, 'S/N') AS materia,
    COALESCE(h.hora_inicio, 'S/N') AS horario_inicio,
    COALESCE(h.hora_fin, 'S/N') AS horario_final,
    COALESCE(g.grupo, 'S/N') AS grupo,
    COALESCE(CONCAT(pd.nombre, ' ', pd.primerapellido, ' ', pd.segundoapellido), 'S/N') AS nombre_docente
FROM
    personas p
LEFT JOIN 
    estudiantes e ON p.id_persona = e.id_persona
LEFT JOIN 
    estudiante_materia em ON e.boleta = em.id_boleta
LEFT JOIN 
    materia m ON em.id_materia = m.id_materia
LEFT JOIN 
    horarios h ON m.id_materia = h.id_materia
LEFT JOIN 
    grupos g ON m.id_materia = g.id_materia
LEFT JOIN 
    docente d ON g.id_profesor = d.id_docente
LEFT JOIN 
    personas pd ON d.id_persona = pd.id_persona;

select * from vista_resumen_alumnos

--Crea una vista que muestre el nombre, apellidos, fecha_nacimiento, delegación, edad, grado_academico y plantel de los docentes.
create view vista_profesores as
select
    p.nombre AS nombre,
	p.primerapellido as primer_apellido,
	p.segundoapellido as segundo_apellido,
	p.fecha_nacimiento as fecha_nacimiento,
	p.delegacion_municipio as delegacion_municipio,
	extract(year from age(current_date,p.fecha_nacimiento)) as edad,
	d.grado_academico,
	pl.nombre_plantel
from personas p
inner join docente d on p.id_persona = d.id_persona
inner join grupos g on d.id_docente = g.id_profesor
inner join materia m on g.id_materia = m.id_materia
inner join carrera c on m.id_carrera = c.id_carrera
inner join plantel pl on c.id_plantel = pl.id_plantel;

select * from vista_profesores	

select * from materia
-- *Genere una vista con la información de las materias, donde se muestre el nombre completo de los docentes que la imparten, 
-- carrera, código de materia, nombre del plantel.
create view vista_materias as
select 
	m.nombre_materia as nombre_profesor,
	m.clave as clave_materia,
	c.nombre_carrera as nombre_carrera,
	pl.nombre_plantel as nombre_plantel,
    CONCAT(p.nombre, ' ', p.primerapellido, ' ', p.segundoapellido) AS nombre_completo
from personas p
inner join docente d on p.id_persona = d.id_persona
inner join grupos g on d.id_docente = g.id_profesor
inner join materia m on g.id_materia = m.id_materia
inner join carrera c on m.id_carrera = c.id_carrera
inner join plantel pl on c.id_plantel = pl.id_plantel;

alter view vista_materias rename column nombre_materia to nombre_profesor

select * from vista_materias