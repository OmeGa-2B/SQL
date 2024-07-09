
/*

Instrucciones
Generar las siguientes consultas en código SQL y envié la evidencia de su sentencia y el resultado.
En caso que la sentencia no envié resultado, ingrese un registro que aplique a la condición. 
Utilice consultas con valores nulos. Envié también el script de las consultas.

*/

/*
1. Es necesario clasificar a los docentes de acuerdo a su edad de la siguiente forma:
18-30                      ->         Docente Joven
30-45            ->         Docente Veterano
45-65  ->         Docente Antiguo
64 o mas    ->     Docente casi Jubilado
*/

SELECT id_persona, id_docente, nombre, clasificacion
FROM (
    SELECT p.id_persona, d.id_docente, p.nombre,
        CASE
            WHEN EXTRACT(YEAR FROM age(p.fecha_nacimiento)) BETWEEN 18 AND 30 THEN 'Docente Joven'
            WHEN EXTRACT(YEAR FROM age(p.fecha_nacimiento)) > 30 AND EXTRACT(YEAR FROM age(p.fecha_nacimiento)) <= 45 THEN 'Docente Veterano'
            WHEN EXTRACT(YEAR FROM age(p.fecha_nacimiento)) > 45 AND EXTRACT(YEAR FROM age(p.fecha_nacimiento)) <= 65 THEN 'Docente Antiguo'
            WHEN EXTRACT(YEAR FROM age(p.fecha_nacimiento)) > 64 THEN 'Docente casi Jubilado'
            ELSE NULL
        END AS clasificacion
    FROM personas AS p
    LEFT JOIN docente AS d ON p.id_persona = d.id_persona
    WHERE d.id_docente IS NOT NULL
    
    UNION
    
    SELECT NULL AS id_persona, d.id_docente, NULL AS nombre, NULL AS clasificacion
    FROM docente d
    WHERE d.id_docente NOT IN (SELECT id_docente FROM personas)
) AS docentes
ORDER BY id_docente;


/*
2. Se desea clasificar a los alumnos de acuerdo con la calificacion obtenida de acuerdo a lo siguiente:
2008640059   <5 calificación        Reprobado
2008630014     5-5.9 calificacion  Aplicar examen de recuperacion
2008740015    6-8.5 calificacion       Aprobado
2008980065   >8.5 calificacion      Exento de Examen
*/


SELECT e.id_persona, e.boleta, em.id_materia, 'Reprobado' AS clasificacion
FROM estudiantes AS e
JOIN estudiante_materia AS em ON e.boleta = em.id_boleta
WHERE em.calificacion < 5

UNION

SELECT e.id_persona, e.boleta, em.id_materia, 'Aplicar examen de recuperacion' AS clasificacion
FROM estudiantes AS e
JOIN estudiante_materia AS em ON e.boleta = em.id_boleta
WHERE em.calificacion BETWEEN 5 AND 5.9

UNION

SELECT e.id_persona, e.boleta, em.id_materia, 'Aprobado' AS clasificacion
FROM estudiantes AS e
JOIN estudiante_materia AS em ON e.boleta = em.id_boleta
WHERE em.calificacion BETWEEN 6 AND 8.5

UNION

SELECT e.id_persona, e.boleta, em.id_materia, 'Exento de Examen' AS clasificacion
FROM estudiantes AS e
JOIN estudiante_materia AS em ON e.boleta = em.id_boleta
WHERE em.calificacion > 8.5
ORDER BY id_persona;
