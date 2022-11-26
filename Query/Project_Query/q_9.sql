
// spliting 
SELECT 
ST_GeomFromText(
	ST_AsText(ST_Split(
		'MULTILINESTRING((10 10, 190 191), (15 15, 30 30, 100 90))',
		ST_Point(30,30))) 
)