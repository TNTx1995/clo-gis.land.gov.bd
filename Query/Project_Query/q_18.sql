

WITH
	P AS (
        SELECT geom AS geometry FROM borolekh where plot_no_en = 1
    ),
	Q AS(SELECT ST_SubDivide(P.geometry,10) AS DividedArea FROM P),
	R AS(
		SELECT
        ST_XMin(ST_Collect(Q.DividedArea)) as x_min,
        ST_XMax(ST_Collect(Q.DividedArea)) as x_max,
        ST_YMin(ST_Collect(Q.DividedArea)) as y_min,
        ST_YMax(ST_Collect(Q.DividedArea)) as y_max,
        ARRAY_TO_STRING(ARRAY_AGG(CONCAT('<path d="', ST_AsSVG(Q.DividedArea), '" ', 'fill="green"','stroke="red"','stroke-width="3"' ,' />')),'') as svg FROM Q,P
	),
	S AS(
		SELECT CONCAT('<svg  height="400" width="400" viewBox="',
        	CONCAT_WS(' ', R.x_min, -1 * R.y_max, R.x_max-R.x_min, R.y_max-R.y_min), '">', R.svg, '</svg>') AS Image FROM R
 
	)
SELECT  S.Image FROM S;









WITH
	P AS(SELECT (ST_DUMP(ST_GeneratePoints(geom,2000))).geom AS geom FROM borolekh where plot_no_en = 1),
	Q AS(SELECT P.geom , ST_ClusterKMeans(P.geom,10) over () AS cluster FROM P ),
	R AS(SELECT Q.cluster,ST_Centroid(ST_Collect(Q.geom)) AS geom FROM Q,P GROUP BY Q.cluster  ),
	S AS(SELECT (ST_Dump(ST_VoronoiPolygons(ST_collect(R.geom)))).geom AS geom FROM R),
	T  AS(SELECT (ST_Intersection(P.geom,S.geom)) AS geom FROM P CROSS JOIN S),
    U AS( SELECT geom AS geometry FROM borolekh where plot_no_en = 1),
    V AS(
		SELECT
        ST_XMin(ST_Collect(U.geom)) as x_min,
        ST_XMax(ST_Collect(U.geom)) as x_max,
        ST_YMin(ST_Collect(U.geom)) as y_min,
        ST_YMax(ST_Collect(U.geom)) as y_max,
        ARRAY_TO_STRING(ARRAY_AGG(CONCAT('<path d="', ST_AsSVG(T.geom), '" ', 'fill="green"','stroke="red"','stroke-width="3"' ,' />')),'') as svg FROM U,T
	),
    W AS(
        SELECT CONCAT('<svg  height="400" width="400" viewBox="',
        	CONCAT_WS(' ', V.x_min, -1 * V.y_max, V.x_max-V.x_min, V.y_max-V.y_min), '">', V.svg, '</svg>') AS Image FROM V
 
    )
    
SELECT V.Image FROM V;
