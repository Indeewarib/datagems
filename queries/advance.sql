--Find the most famous paths visited during a specific time period (e.g., last month):
SELECT t.name_it AS tour_name, COUNT(lvc.id_vc) AS visit_count FROM LOG_VC lvc JOIN TOUR t ON lvc.poi = t.classid WHERE lvc.istante BETWEEN '2019-12-01' AND '2019-12-31' GROUP BY t.name_it ORDER BY visit_count DESC;
--Retrieve POIs, their paths, and Verona Card activation statistics:
SELECT a.name_it AS poi_name, t.name_it AS tour_name, COUNT(lvc.id_vc) AS activation_count FROM ART a JOIN location loc ON a.classid = loc.event JOIN tour t ON loc.classid = t.classid JOIN LOG_VC lvc ON a.classid = lvc.poi GROUP BY a.name_it, t.name_it ORDER BY activation_count DESC;
--Calculate the average tour duration and length across all paths:
SELECT AVG(duration) AS avg_duration, AVG(length) AS avg_length
FROM tour;
