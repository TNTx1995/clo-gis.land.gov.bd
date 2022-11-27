WITH
	P AS(SELECT (ST_DUMP(ST_GeneratePoints(geom,2000))).geom AS geom FROM borolekh where plot_no_en = 1),
	Q AS(SELECT P.geom , ST_ClusterKMeans(P.geom,10) over () AS cluster FROM P ),
	R AS(SELECT Q.cluster,ST_Centroid(ST_Collect(Q.geom)) AS geom FROM Q,P GROUP BY Q.cluster  ),
	S AS(SELECT (ST_Dump(ST_VoronoiPolygons(ST_collect(R.geom)))).geom AS geom FROM R),
	T  AS(SELECT ST_AsGeoJson(ST_Intersection(P.geom,S.geom)) AS geom FROM P CROSS JOIN S)
SELECT T.geom FROM T;