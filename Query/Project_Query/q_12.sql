
//-- divide a polygon into 5 parts 


SELECT row_number() OVER() As rn, ST_AsGeoJson(geom) As geojson , ST_Area(geom)sqft
    FROM (
		SELECT ST_SubDivide(
        'POLYGON((132 10,119 23,85 35,68 29,66 28,49 42,32 56,22 64,32 110,40 119,36 150,
        57 158,75 171,92 182,114 184,132 186,146 178,176 184,179 162,184 141,190 122,
        190 100,185 79,186 56,186 52,178 34,168 18,147 13,132 10))'::geometry,10
		)
	)  
AS f(geom);



select ST_Area(geom) sqft
from (
         select 'SRID=2249;POLYGON((743238 2967416,743238 2967450,
				 743265 2967450,743265.625 2967416,743238 2967416))' :: geometry geom
     ) subquery;



// convert a polygon into 2 equal parts along with N-S axis 

WITH foo AS (
  SELECT geom, blade
  FROM ST_MakeEnvelope(-10,-10,10,10) AS geom
  CROSS JOIN LATERAL ( SELECT ST_xMin(geom) + (ST_xMax(geom) - ST_xMin(geom)) / 2 ) AS axis(x)
  CROSS JOIN LATERAL ST_MakeLine(
    ST_MakePoint(axis.x, ST_yMin(geom)),
    ST_MakePoint(axis.x, ST_yMax(geom))
  ) AS blade
)
SELECT ST_AsText(geom),
  ST_AsText(blade),
  ST_AsText( ST_Split(geom, blade) )
FROM foo;



