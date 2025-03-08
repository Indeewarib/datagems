select name_it from public.event_category where classid in(select category from a_event_category_event_category where event in( select classid from public.event where classid in (select event from public.location where address like '%Arena anfiteatro%')));
select event from calendar where day>='2015-10-10' intersect select event from a_event_category_event_category where category in( select classid from event_category where name_it='Mostre');
select v.id_veronacard from public.visits as v, public.art as a, public.a_art_tour_tour as aa where
v.poi=a.classid and a.classid=aa.point_of_interest and aa.tour = '3';
select * from public.event where classid in(select event from public.a_event_category_event_category where category= (select classid from public.event_category WHERE name_it = 'Mostre') intersect select event from public.calendar  where day = '2015-10-16' );
SELECT ora_visita,COUNT(*) AS most_visited_time FROM visits GROUP BY  ora_visita
ORDER BY most_visited_time DESC;
SELECT 
    TO_CHAR(data_visita, 'YYYY-MM') AS visit_month, 
    COUNT(*) AS visit_count
FROM 
    visits
GROUP BY 
    visit_month
ORDER BY 
    visit_month DESC;

