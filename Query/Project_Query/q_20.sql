

WITH
    P AS (SELECT geom AS geometry FROM borolekh WHERE Plot_no_en IN(1,2,3,4) ),
    Q AS (SELECT ARRAY_TO_STRING(ARRAY_AGG(CONCAT( ST_AsSVG(geometry))),'') as svg FROM P )
SELECT
     CONCAT(Q.svg) FROM Q