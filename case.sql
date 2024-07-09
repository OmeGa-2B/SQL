
/*Clasifica a los alumnos de acuerdo con el promedio que tienen de acuerdo a lo siguiente:
3< ..... Sin Derecho a ETS
3 a 5 ..... Con derecho a ETS
5 a 8 Curso de Recuperacion
8-mas..... Materia Aprobada*/

SELECT e.id_persona, e.boleta, em.id_materia,em.calificacion,(
	case when em.calificacion < 3 then 'Sin derecho a ETS'
		 when em.calificacion between 3 and 5 then 'Con derecho a ETS'
		 when em.calificacion between 5 and 8 then 'Curso de recuperacion'
		 when em.calificacion > 8 or em.calificacion = 8 then 'Materia Aprobada'
		else null
	end) as clasificacion
FROM estudiantes AS e
JOIN estudiante_materia AS em ON e.boleta = em.id_boleta


--cGenere el siguiente reporte a partir del formato que se presenta a continuacion:

 /* PROMEDIO            CANTIDAD           CARRERA                   PLANTEL
-------------------------------------------------------------------------------------
            0              #               CUALQUIERA               CUALQUIERA
-------------------------------------------------------------------------------------
            0-6            #               SUPERIOR                 CUALQUIERA
                           #               MAESTRIA                 CUALQUIERA
                           #               DOCTORADO                CUALQUIERA
-------------------------------------------------------------------------------------
            6-8            #               SUPERIOR                 CUALQUIERA
                           #               MAESTRIA                 CUALQUIERA
                           #               DOCTORADO                CUALQUIERA
-----------------------------------------------------------------------------------------      
  8 O MAS                  #                        APROBADOS                      
-------------------------------------------------------------------------------------
*/
WITH estudiante_promedios AS (
    SELECT
        em.id_boleta,
        AVG(em.calificacion) AS promedio,
        CASE
            WHEN m.id_materia IN (5,15,14,16,9,26) THEN 'DOCTORADO'
            WHEN m.id_materia IN (6,7,12,19,13,4,21,20,25,8) THEN 'MAESTRIA'
            ELSE 'SUPERIOR'
        END AS carrera,
        'CUALQUIERA' AS plantel
    FROM
        estudiante_materia em
        JOIN materia m ON em.id_materia = m.id_materia
    GROUP BY
        em.id_boleta, carrera
), 

rangos AS (
    SELECT
        CASE
            WHEN promedio = 0 THEN '0'
            WHEN promedio > 0 AND promedio <= 6 THEN '0-6'
            WHEN promedio > 6 AND promedio < 8 THEN '6-8'
            WHEN promedio >= 8 THEN '8 O MAS'
        END AS rango_calificacion,
        carrera,
        'CUALQUIERA' AS plantel
    FROM
        estudiante_promedios
)
SELECT
    rango_calificacion,
    COUNT(*) AS cantidad,
    CASE
        WHEN rango_calificacion = '8 O MAS' THEN 'APROBADOS'
        ELSE carrera
    END AS carrera,
    'CUALQUIERA' AS plantel
FROM
    rangos
GROUP BY
    rango_calificacion,
    CASE
        WHEN rango_calificacion = '8 O MAS' THEN 'APROBADOS'
        ELSE carrera
    END
ORDER BY
    rango_calificacion, carrera;

