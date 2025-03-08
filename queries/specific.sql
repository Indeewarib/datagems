--Find the most frequently visited POIs using Verona Card activations:
SELECT a.name_it AS poi_name, COUNT(lvc.poi) AS visit_count FROM LOG_VC lvc JOIN art a ON lvc.poi = a.classid GROUP BY a.name_it ORDER BY visit_count DESC LIMIT 5;
--Get all paths that are part of a tour, including proximity area and duration:
SELECT t.name_it AS tour_name, t.proximity_area, t.duration
FROM TOUR t
WHERE t.proximity_area IS NOT NULL;
--Retrieve tours that include specific points of interest:
SELECT t.name_it AS tour_name, a.name_it AS poi_name
FROM tour t JOIN location loc ON t.classid = loc.classid
JOIN ART a ON loc.num = 1 AND loc.event = a.classid WHERE a.name_it = 'Castelvecchio Museum';
--Find the most famous tour paths based on tourist activity:
SELECT t.name_it AS tour_name, COUNT(lvc.id_vc) AS visit_count
FROM tour t JOIN log_vc lvc ON t.classid = lvc.poi GROUP BY t.name_it
ORDER BY visit_count DESC LIMIT 3;
--List all available paths with translation options for their names:
SELECT t.name_it AS tour_name, tnt.name_trad_value AS translated_name, tnt.name_trad_lang AS language
FROM TOUR t
JOIN TOUR_NAME_TRAD_T tnt ON t.classid = tnt.classref;



