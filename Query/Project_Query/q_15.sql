



//---------------------------------------------------


Convert a polygon into n pieces : 



SELECT row_number() OVER() As rn, ST_AsGeoJson(geom) As geojson , ST_Area(geom)sqft
    FROM (
		SELECT ST_SubDivide(
			'POLYGON((132 10,119 23,85 35,68 29,66 28,49 42,32 56,22 64,32 110,40 119,36 150,
			57 158,75 171,92 182,114 184,132 186,146 178,176 184,179 162,184 141,190 122,
			190 100,185 79,186 56,186 52,178 34,168 18,147 13,132 10))'::geometry,10
		)
	)  
AS f(geom)

Alternative Query : 



WITH 
	Q AS(SELECT geom FROM borolekh where plot_no_en = 1)
SELECT ST_SubDivide(Q.geom,10) FROM Q;

