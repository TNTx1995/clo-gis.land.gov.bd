


//Marging between  multiple polygon !! 


SELECT 
ST_GeomFromGeoJSON(
    ST_AsGeoJSON(
	    ST_ConcaveHull(
		  ST_Collect( ARRAY(
							  select 
							  "geom"
							  from mza_1
							  where "plot_no_en" in (5) 
							  ) 
					  ),0.99 
				  )
	
            )


)



