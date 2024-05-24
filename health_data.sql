USE health_data;
SELECT * FROM health_data;


FINDING THE LIFE EXPECTANCY FOR EACH COUNTRY AND YEAR ALONG WITH AVERAGE LIFE EXPECTANCY FOR THAT COUNTRY OVER ALL YEARS;
SELECT year, country, life_expectancy, round(AVG(life_expectancy) OVER(PARTITION BY country),1)AS average_life_expectancy
FROM health_data;


FINDING COUNTRIES WITH A LIFE EXPECANTCY INCREASE OF MORE THAN 5 YEARS FROM ONE YEAR TO THE NEXT;

WITH life_change AS (SELECT country, year, life_expectancy, LAG(life_expectancy,1) OVER(PARTITION BY country ORDER BY year) AS prev_life_expect
 FROM health_data
 )
 SELECT country, year, life_expectancy, round((life_expectancy - prev_life_expect),1) AS increase_life_expect
 FROM life_change
 WHERE prev_life_expect IS NOT NULL
 AND (life_expectancy - prev_life_expect) > 5;




FINDING COUNTRIES WHO HAVE A LIFE EXPECTANY ABOVE THE AVERAGE AND WHETHER THEY ARE DEVELOPING OR DEVELOPED COUNTRIES.;
SELECT country, status
FROM health_data
WHERE life_expectancy > (
SELECT ROUND(AVG(life_expectancy),1)
FROM health_data) 
GROUP BY COUNTRY;

FINDING countries whos BMI is greater than the average
SELECT country
FROM health_data
WHERE BMI >
(SELECT AVG(BMI)
FROM health_data);


FINDING HOW MANY COUNTRIES ARE DEVELOPING AND DEVELOPED THROUGHTOUT THE YEARS;
SELECT year, status, COUNT(DISTINCT country) AS total_countries
FROM health_data
WHERE status IN ('developed', 'developing')
GROUP BY status, year
ORDER BY year DESC;

FINDING COUNTRIES THAT WHERE THE LIFE EXPECTANCY IS GREATED THAN 75;
SELECT country, life_expectancy
FROM health_data 
WHERE life_expectancy > 75
GROUP BY country;

AVERAGE LIFE EXPECTANCY BY COUNTRY;
SELECT country, round(AVG(life_expectancy),1) AS life_expectnacy
FROM health_data
GROUP BY country;

AVERAGE LIFE EXPECTANCY AND AVERAGE GDP FOR EACH COUNTRY WHERE THE YEAR IS AFTER 2000;
SELECT country, round((life_expectancy),2) AS avg_life_expectancy , round(AVG(GDP),1) AS avg_gdp
FROM health_data
WHERE YEAR > 2000
GROUP BY country
ORDER BY GDP DESC;




