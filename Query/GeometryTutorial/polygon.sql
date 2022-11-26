

-- Make Line from two points 
SELECT ST_AsGeoJson(ST_AsText( ST_MakeLine(ST_Point(1,2), ST_Point(3,4)) ));

-- Make All the points from a polygon 
SELECT ST_AsText(ST_Centroid(geom)) FROM borolekh;
