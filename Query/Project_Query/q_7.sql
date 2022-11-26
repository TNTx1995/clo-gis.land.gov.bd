

WITH
    query AS (
            SELECT 
                ST_GeomFromGeoJSON(
                    ST_AsGeoJSON(
                        ST_ConcaveHull(
                        ST_Collect( ARRAY(
                                            select 
                                            "geom"
                                            from mza_1
                                            where "plot_no_en" in (1,2,3) 
                                            ) 
                                    ),0.99 
                                )
                    
                            )


                )
         ),
    q AS (SELECT
        ST_XMin(ST_Collect(geometry)) as x_min,
        ST_XMax(ST_Collect(geometry)) as x_max,
        ST_YMin(ST_Collect(geometry)) as y_min,
        ST_YMax(ST_Collect(geometry)) as y_max,
        ARRAY_TO_STRING(ARRAY_AGG(CONCAT('<path d="', ST_AsSVG(geometry), '" ', 'fill="none"', ' />')),'') as svg FROM query )
SELECT
    CONCAT('<svg stroke="black" stroke-solid="3"  height="400" width="400" viewBox="',
        CONCAT_WS(' ', q.x_min, -1 * q.y_max, q.x_max-q.x_min, q.y_max-q.y_min), '">', q.svg, '</svg>') FROM q