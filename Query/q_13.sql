

WITH 
    query AS (SELECT geom AS geometry FROM borolekh where plot_no_en = 1 ),
	X As(SELECT ST_Area(geom) as Plot_Area , plot_no_en ,m_thana_en from borolekh where plot_no_en = 1),
    q AS (SELECT
        ST_XMin(ST_Collect(geometry)) as x_min,
        ST_XMax(ST_Collect(geometry)) as x_max,
        ST_YMin(ST_Collect(geometry)) as y_min,
        ST_YMax(ST_Collect(geometry)) as y_max,
        ARRAY_TO_STRING(ARRAY_AGG(CONCAT('<path d="', ST_AsSVG(geometry), '" ', 'fill="none"', ' />')),'') 
		as svg FROM query )

SELECT
    CONCAT('<svg stroke="black" stroke-solid="3"  height="400" width="400" viewBox="',
       CONCAT_WS(' ', q.x_min, -1 * q.y_max, q.x_max-q.x_min, q.y_max-q.y_min), '">',
		   CONCAT('<text x=''>',X.Plot_Area,X.plot_no_en,X.m_thana_en,'</text>') ,q.svg, '</svg>') FROM q,X
		