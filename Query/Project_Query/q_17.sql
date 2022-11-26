
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
        ARRAY_TO_STRING(ARRAY_AGG(CONCAT('<path d="', ST_AsSVG(Q.DividedArea), '" ', 'fill="green"', ' />')),'') as svg FROM Q,P
	),
	S AS(
		SELECT CONCAT('<svg  height="400" width="400" viewBox="',
        	CONCAT_WS(' ', R.x_min, -1 * R.y_max, R.x_max-R.x_min, R.y_max-R.y_min), '">', R.svg, '</svg>') AS Image FROM R
 
	)
SELECT  S.Image FROM S;




-- WITH 
-- 	Q AS(SELECT geom FROM borolekh where plot_no_en = 1)
-- SELECT ST_Area(ST_SubDivide(Q.geom,10)),ST_SubDivide(Q.geom,10) FROM Q;
