

WITH
    query AS (SELECT geom AS geometry FROM borolekh where plot_no_en = 1 ),
    q AS (SELECT
        ST_XMin(ST_Collect(geometry)) as x_min,
        ST_XMax(ST_Collect(geometry)) as x_max,
        ST_YMin(ST_Collect(geometry)) as y_min,
        ST_YMax(ST_Collect(geometry)) as y_max,
        ARRAY_TO_STRING(ARRAY_AGG(CONCAT('<path d="', ST_AsSVG(geometry), '" ', 'fill="none"', ' />')),'') as svg FROM query )
SELECT
    CONCAT('<svg stroke="black" stroke-solid="3"  height="400" width="400" viewBox="',
        CONCAT_WS(' ', q.x_min, -1 * q.y_max, q.x_max-q.x_min, q.y_max-q.y_min), '">', q.svg, '</svg>') FROM q




WITH
	P AS (
        SELECT geom FROM borolekh where plot_no_en = 1
    ),
	Q AS (
        SELECT
        ST_XMin(ST_Collect(geometry)) as x_min,
        ST_XMax(ST_Collect(geometry)) as x_max,
        ST_YMin(ST_Collect(geometry)) as y_min,
        ST_YMax(ST_Collect(geometry)) as y_max,
        ARRAY_TO_STRING(ARRAY_AGG(CONCAT('<path d="', ST_AsSVG(geometry), '" ', 'fill="none"', ' />')),'')
        as svg FROM P 
    )
	
SELECT ST_Area(P.geom),ST_AsGeoJson(ST_SubDivide(P.geom,5)),
 CONCAT('<svg stroke="black" stroke-solid="3"  height="400" width="400" viewBox="',
        CONCAT_WS(' ', Q.x_min, -1 * Q.y_max, Q.x_max-Q.x_min, Q.y_max-Q.y_min), '">', Q.svg, '</svg>')
 FROM P,Q;