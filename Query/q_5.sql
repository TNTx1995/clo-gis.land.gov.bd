WITH
    query AS (SELECT geom AS geometry FROM borolekh where plot_no_en = 1  ),
    q AS 
	(
		SELECT
        ST_XMin(ST_Collect(geometry)) as x_min,
        ST_XMax(ST_Collect(geometry)) as x_max,
        ST_YMin(ST_Collect(geometry)) as y_min,
        ST_YMax(ST_Collect(geometry)) as y_max,
        ARRAY_TO_STRING(
			ARRAY_AGG(
				CONCAT('<path d="', ST_AsSVG(geometry), '" ', 'fill="red"', ' />')
			),''
		) as svg FROM query
	)
				

SELECT
     	CONCAT('','', '', q.svg, '') 
FROM q




        