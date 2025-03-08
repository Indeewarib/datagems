### **General Queries**

These queries retrieve fundamental information about tours, points of interest (POIs), categories, events, and more. They provide basic details for the database exploration.

**Retrieve all available tours and their descriptions:** 

`SELECT name_it AS tour_name, descr_it AS description FROM TOUR;`  

**List all points of interest (POIs) and their open times:**  

`SELECT name_it AS poi_name, open_time FROM ART;`  

**Get all tourist categories and their names:** 

`SELECT cat_id, name_it AS category_name FROM CATEGORY;`  

**Retrieve all tours grouped by their type:**  

`SELECT t.type, COUNT(t.classid) AS num_tours FROM TOUR t JOIN TOUR_TYPE tt ON t.type = tt.id GROUP BY t.type;`  

**Find all events and their associated categories:** 

`SELECT e.name_it AS event_name, ec.category FROM EVENT e  JOIN EVENT_CATEGORY ec ON e.event_id = ec.event;`  

---

### **Intermediate Queries**

These queries provide more complex insights, combining multiple tables and conditions to deliver detailed and segmented results.

**List all points of interest that belong to specific categories:**  

`SELECT a.name_it AS poi_name, c.name_it AS category_name FROM ART a JOIN ART_CATEGORY ac ON a.poi_id = ac.poi_id JOIN CATEGORY c ON ac.cat_id = c.cat_id;` 

**Get the schedule of a specific POI (e.g., Verona Arena):** 

`SELECT cal.day, cal.start_time, cal.end_time FROM CALENDAR cal JOIN LOCATION loc ON cal.classid = loc.classid JOIN ART a ON loc.num = 1 AND loc.event = a.poi_id WHERE a.name_it = 'Verona Arena';`  

**Retrieve all tours with their estimated duration and length:**  

`SELECT name_it AS tour_name, duration, length FROM TOUR;` 
 
**List all translation options for tour descriptions:**  

`SELECT trad AS language, value AS description FROM TOUR_DESCR_TRAD;`  
---

### **Specific Queries**

Focused on particular cases, these queries address specific scenarios such as identifying the most popular points of interest, specific tours, and tourist behaviors.

**Find the most frequently visited POIs using Verona Card activations:**

`SELECT a.name_it AS poi_name, COUNT(lvc.art) AS visit_count FROM LOG_VC lvc JOIN art a ON lvc.art = a.poi_id GROUP BY a.name_it ORDER BY visit_count DESC LIMIT 5;`

**Get all paths that are part of a tour, including proximity area and duration:**

`SELECT t.name_it AS tour_name, t.proximity_area, t.duration`  
`FROM TOUR t`  
`WHERE t.proximity_area IS NOT NULL;`  
**Retrieve tours that include specific points of interest:**  
`SELECT t.name_it AS tour_name, a.name_it AS poi_name`  
`FROM tour t JOIN location loc ON t.classid = loc.classid`  
`JOIN ART a ON loc.num = 1 AND loc.event = a.poi_id WHERE a.name_it = 'Castelvecchio Museum';`  
**Find the most famous tour paths based on tourist activity:**  
`SELECT t.name_it AS tour_name, COUNT(lvc.id_vc) AS visit_count`  
`FROM tour t JOIN log_vc lvc ON t.classid = lvc.art GROUP BY t.name_it`  
`ORDER BY visit_count DESC LIMIT 3;`  
**List all available paths with translation options for their names:**  
`SELECT t.name_it AS tour_name, tnt.value AS translated_name, tnt.trad AS language`  
`FROM TOUR t`  
`JOIN TOUR_NAME_TRAD tnt ON t.classid = tnt.poi_id;`  
**Find tours that cover the most POIs in a given category (e.g., "Art and Culture"):**  
`SELECT t.name_it AS tour_name, COUNT(ac.poi_id) AS num_pois`  
`FROM TOUR t JOIN location loc ON t.classid = loc.classid`  
`JOIN art_category ac ON loc.event = ac.poi_id JOIN CATEGORY c ON ac.cat_id = c.cat_id WHERE c.name_it = 'Art and Culture'`  
`GROUP BY t.name_it ORDER BY num_pois DESC;`  
---

### **Advanced Queries**

These queries aim for more advanced analysis, focusing on trends, specific periods, or special conditions.

**Find the most famous paths visited during a specific time period (e.g., last month):**

`SELECT t.name_it AS tour_name, COUNT(lvc.id_vc) AS visit_count FROM LOG_VC lvc JOIN TOUR t ON lvc.art = t.classid WHERE lvc.date_time BETWEEN '2024-12-01' AND '2024-12-31' GROUP BY t.name_it ORDER BY visit_count DESC;`

**Identify the best-rated paths based on weather conditions (e.g., no rain, moderate wind).**

`SELECT t.name_it AS tour_name, w.data, w.wind, w.rain FROM tour t JOIN WEATHER w ON w.station_id = t.classid WHERE w.rain = 0 AND w.wind < 10;`

**Retrieve POIs, their paths, and Verona Card activation statistics:**

`SELECT a.name_it AS poi_name, t.name_it AS tour_name, COUNT(lvc.id_vc) AS activation_count FROM ART a JOIN location loc ON a.poi_id = loc.event JOIN tour t ON loc.classid = t.classid JOIN LOG_VC lvc ON a.poi_id = lvc.art GROUP BY a.name_it, t.name_it ORDER BY activation_count DESC;`  
**Find paths near a specific POI within a given proximity area:**  
`SELECT t.name_it AS tour_name, t.proximity_area FROM TOUR t`  
`JOIN location loc ON t.classid = loc.classid WHERE loc.event = (SELECT poi_id FROM ART WHERE name_it = 'Piazza delle Erbe') AND t.proximity_area < 1;  -- Proximity area within 1 km`  
**Calculate the average tour duration and length across all paths:**  
`SELECT AVG(duration) AS avg_duration, AVG(length) AS avg_length`  
`FROM tour;`

---

**Queries by…**

Queries based on user roles or specific types of data are categorized here.

* **Exploration:** Focuses on the most updated categories, connections to historical themes, and identifying events associated with specific locations (e.g., Piazza delle Erbe).  
* **Natural Language:** Aimed at understanding and presenting data based on descriptive queries (e.g., "What are the upcoming events categorized as 'Exhibitions' in Verona?").  
* **Pattern:** Queries identify trends or patterns (e.g., frequently occurring event types near tourist landmarks).  
* **Query Pattern:** Extracts more complex queries related to specific conditions like duration or multimedia resources.  
* **Example-Based:** Based on real-life scenarios such as event categorization and historical themes.

*By Exploration*

* Which categories of RSS feeds are most frequently updated?   
* Which events or tours have connections to historical themes in their descriptions?  
* *Which galleries feature art with multimedia resources?*  
* *What events are associated with Piazza delle Erbe?*  
* *Which tours are connected to multimedia resources?*  
* *Which RSS feeds were updated in the past week?*  
* *Which points of interest (POI) had the highest popularity on days with rain?*

*By Natural Language*

* What are the details of the artwork displayed in Gallery X?  
* What are the upcoming events categorized as 'Exhibitions' in Verona for the next 30 days?  
* Which tours include artworks from the 18th century?  
* Where are the top-rated galleries located in Verona?  
* *What are the available artworks in the 'Modern Art' category in Verona?*  
* *What are the exhibitions in Verona for the next 30 days?*  
* *What are the tours in Verona lasting less than 3 hours?*  
* *What are the media resources linked to popular tours in Verona?*  
* *What are the addresses of the top-rated galleries in Verona?*  
* Show all the recorded rainfall data for 2014\.  
* How many tourists visited Verona on January 2nd, 2014?  
* What were the temperature conditions on January 2nd, 2014?

*By Pattern*

* Which types of events frequently occur near tourist landmarks in Verona?  
* *What is the temperature for each POI on a specific day?*

*By Query Pattern*

* Find tours where the duration is less than 3 hours and includes multimedia resources.  
* *Find all artworks with available descriptions in Italian.*  
* *List the tours covering 'Renaissance Art’.*  
* *Which locations hosted more than 5 events last year?*

*By Example*

* Show details of any event categorized as ‘Festival’ with a start date in the next month.  
* *Show the details of the art pieces linked to the Monument category.*  
* *List the events held in Verona that include both an exhibition and a concert.*

EXTRA  
Specific queries for different stakeholders in the tourism database ecosystem, such as curators, event organizers, tour guides, and administrators.

#### **Curators or Researchers**

* "How many artworks in the database belong to the category 'Modern Art' and are currently exhibited?" *(by-query-pattern)*  
* "Provide a list of artworks with descriptions in English for translation purposes." *(by-example)*

#### **Event Organizers**

* "Which events linked to location A have the highest attendance?" *(by-exploration)*

#### **Tour Guides**

* "Which tours require the least updates to their descriptions in the English language?" *(by-example)*

#### **Content Managers**

* "Find multimedia resources used in the top 3 most popular tours." *(by-query-pattern)*  
* "What updates in the RSS feed for cultural events were published last week?" *(by-natural-language)*

#### **Administrators**

* "Which locations have hosted more than 10 events in the last year?" *(by-example)*

#### **Translators**

* "Provide all event descriptions in Italian for translation into German." *(by-example)*

#### **System Analysts**

* "Which language codes are missing descriptions for the 'TOUR' entity?" *(by-query-pattern)*

**Selected queries to try**

* Show details of any event categorized as ‘Mostre’ with scheduled on ‘2015-10-16’.  
* Show the details of the art pieces linked to the Monument category.  
* List the events held in Verona that include both an exhibition and a concert.  
* What are the places covering/belong to  'Renaissance Art/Verona’.  
* Which types of events frequently occur near Arena anfiteatro?   
* What are the upcoming events categorized as 'Exhibitions' in Verona?(ex: after 2015-10-10)  
* What are the available artworks/places in the church category in Verona?  
* What are the exhibitions in Verona on ‘yyyy-mm-dd’?  
* What are the tours in Verona lasting less than 3 hours?  
* Which events or tours have connections to historical themes in their descriptions?  
* *What events are associated with Piazza Erbe?*

**Which types of events frequently occur near Arena anfiteatro?** 

select name\_it from public.event\_category where classid in(select category from a\_event\_category\_event\_category where event in( select classid from public.event where classid in (select event from public.location where address like '%Arena anfiteatro%')))

**What are the upcoming events categorized as 'Exhibitions' in Verona?(ex: after 2015-10-10)**

select event from calendar where day\>='2015-10-10' intersect select event from a\_event\_category\_event\_category where category in( select classid from event\_category where name\_it='Mostre')

**Visitors who enjoyed ‘Roman Verona’ tour**

select v.id\_veronacard from public.visits as v, public.art as a, public.a\_art\_tour\_tour as aa where  
v.poi=a.classid and a.classid=aa.point\_of\_interest and aa.tour \= '3'

**Show details of any event categorized as ‘Mostre’ with scheduled on ‘2015-10-16’.**

select \* from public.event where classid in(select event from public.a\_event\_category\_event\_category where category= (select classid from public.event\_category WHERE name\_it \= 'Mostre') intersect select event from public.calendar  where day \= '2015-10-16' )

**Show the details of the art pieces linked to the Monument category.**

select \* from public.art where classid in (select points from public.a\_art\_category\_art\_category where category in(select classid from public.art\_category where name\_it='Monumenti'))

**List the events held in Verona that include both an exhibition and a concert.**

select event from public.a\_event\_category\_event\_category where category in( select classid from public.event\_category where name\_it='Mostre' and name\_it='Concert')  intersect select event from public.location where address like '%Verona'  – this part is optional

**What are  the places covering/belonging to  'Renaissance Art/Verona’.**

select point\_of\_interest from public.a\_art\_tour\_tour where tour in(select classid from public.tour where classid in( select classref from public.tour\_name\_trad\_t where name\_trad\_value like '%Renaissance'))

**What are the available artworks/places in the church category in Verona?**

select classid,name\_it from public.art where classid in(select points from a\_art\_category\_art\_category where category in (select classid from art\_category where name\_it='Chiese'))

**Paths visited by a tourist.**  
SELECT   
    id\_veronacard,  
    STRING\_AGG(sito\_nome, ' \-\> ' ORDER BY data\_visita, ora\_visita) AS path  
FROM   
    visits  
GROUP BY   
    Id\_veronacard;

**Mostly visited places.**  
SELECT sito\_nome,COUNT(\*) AS most\_visited FROM visits GROUP BY  sito\_nome  
ORDER BY  most\_visited DESC

**Peak visiting hours.**  
SELECT ora\_visita,COUNT(\*) AS most\_visited\_time FROM visits GROUP BY  ora\_visita  
ORDER BY most\_visited\_time DESC

**Monthly visiting trends.**  
SELECT   
    TO\_CHAR(data\_visita, 'YYYY-MM') AS visit\_month,   
    COUNT(\*) AS visit\_count  
FROM   
    visits  
GROUP BY   
    visit\_month  
ORDER BY   
    visit\_month DESC;

**Identify the typical number of POIs visited by a tourist in a day.**  
select  id\_veronacard,data\_visita,COUNT(DISTINCT sito\_nome) AS no\_time\_visited   
from visits group by id\_veronacard,data\_visita order by no\_time\_visited DESC