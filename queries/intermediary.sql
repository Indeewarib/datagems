--List all points of interest that belong to specific categories:
SELECT a.name_it AS poi_name, c.name_it AS category_name FROM ART a
JOIN ART_CATEGORY ac ON a.classid = ac.classid JOIN art_category c ON ac.classid = c.classid;
--Get the schedule of a specific POI (e.g., Verona Arena):
SELECT cal.day, cal.start_time, cal.end_time FROM CALENDAR cal
JOIN LOCATION loc ON cal.classid = loc.classid JOIN ART a ON loc.num = 1 AND loc.event = a.classid WHERE a.name_it = 'Verona Arena';
--Retrieve all tours with their estimated duration and length:
SELECT name_it AS tour_name, duration, length FROM TOUR;
--List all translation options for tour descriptions:
SELECT classref AS language, descr_trad_lang AS description FROM TOUR_DESCR_TRAD_T;


