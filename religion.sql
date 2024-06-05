-- creating oceanian religion table
create table oceania (
	country varchar primary key,
	region varchar,
	population varchar,
	christian varchar,
	muslim varchar,
	irreligion varchar,
	hindu varchar,
	buddhist varchar,
	folk_religion varchar,
	other_religion varchar,
	jewish varchar);

	
copy oceania (country, region, population, christian, muslim, irreligion, hindu, buddhist, folk_religion, other_religion, jewish)
from '/Users/alecreynoso/Desktop/Data Analysis Projects/Religion/Excel/Oceania religion.csv'
delimiter ','
csv header;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- creating american religion table
create table america (
	country varchar primary key,
	region varchar,
	population varchar,
	christian varchar,
	muslim varchar,
	irreligion varchar,
	hindu varchar,
	buddhist varchar,
	folk_religion varchar,
	other_religion varchar,
	jewish varchar);

	
copy america (country, region, population, christian, muslim, irreligion, hindu, buddhist, folk_religion, other_religion, jewish)
from '/Users/alecreynoso/Desktop/Data Analysis Projects/Religion/Excel/Religion Americas.csv'
delimiter ','
csv header;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- creating asian religion table
create table asia (
	country varchar primary key,
	region varchar,
	population varchar,
	christian varchar,
	muslim varchar,
	irreligion varchar,
	hindu varchar,
	buddhist varchar,
	folk_religion varchar,
	other_religion varchar,
	jewish varchar);
	

copy asia (country, region, population, christian, muslim, irreligion, hindu, buddhist, folk_religion, other_religion, jewish)
from '/Users/alecreynoso/Desktop/Data Analysis Projects/Religion/Excel/Religion Asia.csv'
delimiter ','
csv header;

-----------------------------------------------------------------------------------------------------------------------------------------------

--creating european religion table
create table europe (
	country varchar primary key,
	region varchar,
	population varchar,
	christian varchar,
	muslim varchar,
	irreligion varchar,
	hindu varchar,
	buddhist varchar,
	folk_religion varchar,
	other_religion varchar,
	jewish varchar,
	pagan varchar);

	
copy europe (country, region, population, christian, muslim, irreligion, hindu, buddhist, folk_religion, other_religion, jewish, pagan)
from '/Users/alecreynoso/Desktop/Data Analysis Projects/Religion/Excel/Religion europe.csv'
delimiter ','
csv header;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- creating table for african religion
create table africa (
	country varchar primary key,
	region varchar,
	population varchar,
	christian varchar,
	muslim varchar,
	irreligion varchar,
	hindu varchar,
	buddhist varchar,
	folk_religion varchar,
	other_religion varchar,
	jewish varchar);
	

copy africa (country, region, population, christian, muslim, irreligion, hindu, buddhist, folk_religion, other_religion, jewish)
from '/Users/alecreynoso/Desktop/Data Analysis Projects/Religion/Excel/Religion_africa.csv'
delimiter ','
csv header;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- Q1: Comparing America and Europe, which continent has more Christians?

select 'christian' as religion, 
		(select sum(christian::numeric) from america) as america,
		(select sum(christian::numeric) from europe) as europe;


-----------------------------------------------------------------------------------------------------------------------------------------------

-- Q2: What percentage of the world is Christian?

with total_christian as
	(select 'christian' as religion, sum(christian::numeric) as christian_total 
	 from africa
	 union all
	 select 'christian', sum(christian::numeric) from america
	 union all
	 select 'christian', sum(christian::numeric) from asia
	 union all
	 select 'christian', sum(christian::numeric) from europe
	 union all
	 select 'christian', sum(christian::numeric) from oceania
),
	total_pop as
	(select 'population' as pop, sum(population::numeric) as total_population 
	 from africa
	 union all
	 select 'population', sum(population::numeric) from america
	 union all
	 select 'population', sum(population::numeric) from asia
	 union all
	 select 'population', sum(population::numeric) from europe
	 union all
	  select 'population', sum(population::numeric) from oceania
)
select 'christian' as religion, round((sum(christian_total) / sum(total_population)) * 100, 2) as percentage
from total_christian, total_pop;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- Q3: In the european continent, what is the dominant religion?

with total_population as (
	select sum(population::numeric) as total_pop
	from europe
)
select
	sum(christian::numeric) as christian, 
	round((sum(christian::numeric) / total_pop) *100, 2) as christian_percentage,
	sum(muslim::numeric) as muslim, 
	round((sum(muslim::numeric) / total_pop) *100, 2) as muslim_percentage,
	sum(irreligion::numeric) as irreligion, 
	round((sum(irreligion::numeric) / total_pop) *100, 2) as irreligion_percentage,
	sum(hindu::numeric) as hindu, 
	round((sum(hindu::numeric) / total_pop) *100, 2) as hindu_percentage,
	sum(buddhist::numeric) as buddhist, 
	round((sum(buddhist::numeric) / total_pop) *100, 2) as buddhist_percentage,
	sum(folk_religion::numeric) as folk_religion, 
	round((sum(folk_religion::numeric) / total_pop) *100, 2) as folk_religion_percentage,
	sum(other_religion::numeric) as other_religion, 
	round((sum(other_religion::numeric) / total_pop) *100, 2) as other_religion_percentage,
	sum(jewish::numeric) as jewish, 
	round((sum(jewish::numeric) / total_pop) *100, 2) as jewish_percentage,
	sum(pagan::numeric) as pagan, 
	round((sum(pagan::numeric) / total_pop) *100, 2) as pagan_percentage
from europe, total_population
group by total_pop

-----------------------------------------------------------------------------------------------------------------------------------------------

-- Q4: What percentage of the world practices Judaism?

with total_judaism as (
	select 'jewish' as religion, sum(jewish::numeric) as total from africa
	union all
	select 'jewish', sum(jewish::numeric) from america
	union all
	select 'jewish', sum(jewish::numeric) from asia
	union all
	select 'jewish', sum(jewish::numeric) from europe
	union all
	select 'jewish', sum(jewish::numeric) from oceania
),
	total_population as (
	select sum(population::numeric) as total_pop from africa
	union all
	select sum(population::numeric) as total_pop from america
	union all
	select sum(population::numeric) as total_pop from asia
	union all
	select sum(population::numeric) as total_pop from europe
	union all
	select sum(population::numeric) as total_pop from oceania
)
select religion, round((sum(total) / sum(total_pop)) * 100, 2)
from total_judaism, total_population
group by religion;

-----------------------------------------------------------------------------------------------------------------------------------------------

-- Q5: What are the top 5 practiced religions in the world?

WITH total_religions AS (
    SELECT 'Christian' AS religion, SUM(christian::numeric) AS total FROM africa
    UNION ALL
    SELECT 'Christian', SUM(christian::numeric) FROM america
    UNION ALL
    SELECT 'Christian', SUM(christian::numeric) FROM asia
    UNION ALL
    SELECT 'Christian', SUM(christian::numeric) FROM europe
    UNION ALL
    SELECT 'Christian', SUM(christian::numeric) FROM oceania
    UNION ALL
    SELECT 'Muslim' AS religion, SUM(muslim::numeric) AS total FROM africa
    UNION ALL
    SELECT 'Muslim', SUM(muslim::numeric) FROM america
    UNION ALL
    SELECT 'Muslim', SUM(muslim::numeric) FROM asia
    UNION ALL
    SELECT 'Muslim', SUM(muslim::numeric) FROM europe
    UNION ALL
    SELECT 'Muslim', SUM(muslim::numeric) FROM oceania
    UNION ALL
    SELECT 'Irreligion' AS religion, SUM(irreligion::numeric) AS total FROM africa
    UNION ALL
    SELECT 'Irreligion', SUM(irreligion::numeric) FROM america
    UNION ALL
    SELECT 'Irreligion', SUM(irreligion::numeric) FROM asia
    UNION ALL
    SELECT 'Irreligion', SUM(irreligion::numeric) FROM europe
    UNION ALL
    SELECT 'Irreligion', SUM(irreligion::numeric) FROM oceania
	UNION ALL
    SELECT 'hindu' AS religion, SUM(hindu::numeric) AS total FROM africa
	UNION ALL
	SELECT 'hindu', SUM(hindu::numeric)FROM america
	UNION ALL
	SELECT 'hindu', SUM(hindu::numeric)FROM asia
	UNION ALL
	SELECT 'hindu', SUM(hindu::numeric)FROM europe
	UNION ALL
	SELECT 'hindu', SUM(hindu::numeric)FROM oceania
	UNION ALL
	SELECT 'buddhist' AS religion, SUM(buddhist::numeric) AS total FROM africa
	UNION ALL
	SELECT 'buddhist', SUM(buddhist::numeric) FROM america
	UNION ALL
	SELECT 'buddhist', SUM(buddhist::numeric) FROM asia
	UNION ALL
	SELECT 'buddhist', SUM(buddhist::numeric) FROM europe
	UNION ALL
	SELECT 'buddhist', SUM(buddhist::numeric) FROM oceania
	UNION ALL
	SELECT 'folk_religion' AS religion, SUM(folk_religion::numeric) AS total FROM africa
	UNION ALL
	SELECT 'folk_religion', SUM(folk_religion::numeric) FROM america
	UNION ALL
	SELECT 'folk_religion', SUM(folk_religion::numeric) FROM asia
	UNION ALL
	SELECT 'folk_religion', SUM(folk_religion::numeric) FROM europe
	UNION ALL
	SELECT 'folk_religion', SUM(folk_religion::numeric) FROM oceania
	UNION ALL
	SELECT 'other_religion' AS religion, SUM(other_religion::numeric) AS total FROM africa
	UNION ALL
	SELECT 'other_religion', SUM(other_religion::numeric) FROM america
	UNION ALL
	SELECT 'other_religion', SUM(other_religion::numeric) FROM asia
	UNION ALL
	SELECT 'other_religion', SUM(other_religion::numeric) FROM europe
	UNION ALL
	SELECT 'other_religion', SUM(other_religion::numeric) FROM oceania
	UNION ALL
	SELECT 'jewish' AS religion, SUM(jewish::numeric) AS total FROM africa
	UNION ALL
	SELECT 'jewish',SUM(jewish::numeric) FROM america
	UNION ALL
	SELECT 'jewish', SUM(jewish::numeric) FROM asia
	UNION ALL
	SELECT 'jewish', SUM(jewish::numeric) FROM europe
	UNION ALL
	SELECT 'jewish', SUM(jewish::numeric) FROM oceania
),
total_population AS (
    SELECT SUM(total) AS total_population FROM total_religions
)
SELECT religion, SUM(total) AS total, ROUND((SUM(total) / total_population) * 100, 2) AS percentage
FROM total_religions, total_population
GROUP BY religion, total_population
ORDER BY percentage DESC
limit 5;

-----------------------------------------------------------------------------------------------------------------------------------------------