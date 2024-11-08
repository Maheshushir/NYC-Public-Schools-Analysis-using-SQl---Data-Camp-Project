create database public_school;
use public_school ; 


/* Introduction -
In the following notebook, we will delve into SAT data from New York City's public schools. 
This information encompasses reading, math, and writing test sections, each with a maximum score of 800 points. 
Given the pivotal role of SATs in the college admissions process, 
the comprehensive analysis of schools' performance is crucial for policy and education professionals, government bodies, researchers, and parents
 making decisions about their children's educational paths.  */ 
 
 
select *
from schools;

/* Find the missing values -
It appears that the first school in our database did not provide data in the percent_tested column, signifying that the percentage of students tested was not reported. 
We need to identify how many schools have missing data in this column. 
This will enable us to gauge the extent of the missing data issue in New York. 
Furthermore, we will calculate the total number of schools in the database to gain a comprehensive understanding of the dataset's scope. */


SELECT 
    COUNT(school_name) - COUNT(percent_tested) AS num_tested_missing,
    COUNT(school_name) AS num_schools
FROM schools;

 
/* Schools by building code - 
Out of all the rows in the database, 20 schools are identified to have missing data for the percent_tested column, 
representing approximately 5% of the total dataset entries.
Another observation made from displaying the initial ten rows of the database is the presence of repeated building_code values, 
indicating that multiple schools might be situated at the same location. To further explore this,
 we aim to determine the count of unique school locations stored in our database.*/

SELECT COUNT(DISTINCT building_code) AS num_school_buildings
FROM schools;

/* Best schools for math - 
Out of the total 375 schools, only 233 (62%) have a unique building_code associated with them.
Moving forward to our analysis of school performance, we will approach the evaluation of each school's performance individually, 
rather than consolidating them by building_code.
To commence our analysis, we will identify all schools with an average math score of at least 80% (out of 800). */

SELECT 
    school_name,
    average_math
FROM schools
WHERE average_math >= 640
ORDER BY average_math DESC;

/* Lowest reading score  -
  
The analysis reveals that there are merely ten public schools in New York City with an average math score reaching or exceeding 640 out of 800.
Shifting focus to the opposite end of the scale, we will extract the singular lowest reading score from the dataset. 
This approach will solely involve identifying the lowest reading score without associating it with any specific school to maintain anonymity.  */ 

SELECT MIN(average_reading) AS lowest_reading
FROM schools;

/*  Best writing school -
The data indicates that the lowest average reading score across schools in New York City falls below 40% of the total available points.
Moving forward, we will now identify the school with the highest average writing score. */

SELECT 
    school_name,
    MAX(average_writing) AS max_writing
FROM schools
GROUP BY school_name
ORDER BY max_writing DESC
LIMIT 1;

/* Top 10 schools - 
Stuyvesant High School achieved an extraordinary average writing score of 693, which is quite remarkable. 
This exceptional performance in writing was complemented by Stuyvesant High School's top math score,
 further solidifying its reputation as one of the premier schools in New York.
To identify other schools that excel across the board, we will assess their performance in reading, writing, and math to pinpoint additional standout institutions. */

SELECT
    school_name,
    SUM(average_math) + SUM(average_reading) + SUM(average_writing) AS average_sat
FROM schools
GROUP BY school_name
ORDER BY average_sat DESC
LIMIT 10;

/* Ranking boroughs - 
Let's construct a query to analyze the performance of schools based on New York City boroughs. 
This query will calculate the total number of schools and the average SAT scores for each borough. */

SELECT 
    borough,
    COUNT(school_name) AS num_schools,
    (SUM(average_math) + SUM(average_reading) + SUM(average_writing))/COUNT(school_name) AS average_borough_sat
FROM schools
GROUP BY borough
ORDER BY average_borough_sat DESC;


/* Brooklyn numbers - 
Upon analysis, it appears that, on average, schools in Staten Island achieve higher scores across all three categories.
 Nonetheless, the number of schools in Staten Island is limited, with only 10 schools, in contrast to an average of 91 schools in the other four boroughs.
For our final database query, we will narrow our focus to Brooklyn, which comprises 109 schools. 
Our objective is to identify the five schools with the highest performance in math.  */

SELECT 
    school_name,
    average_math
FROM schools
WHERE borough = 'Brooklyn'
ORDER BY average_math DESC
LIMIT 5;