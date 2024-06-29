-- Project in MYSQL

/* Create the database with name "travel"
CREATE DATABASE TRAVEL */

/* Upload of csv files as tables for the newly created database
Right click on database "travel" (SCHEMAS SECTION) -> Table Data Import Wizard*/

-- Analysis of the table "american_deaths_abroad"
USE TRAVEL;


SELECT DISTINCT CAUSE_OF_DEATH  
FROM AMERICAN_DEATHS_ABROAD;

SELECT 
COUNTRY,
count(CAUSE_OF_DEATH) AS COUNT_COD
FROM AMERICAN_DEATHS_ABROAD
WHERE CAUSE_OF_DEATH <> "suicide"
GROUP BY COUNTRY
ORDER BY COUNT_COD DESC;

SELECT 
COUNTRY,
right(DATE,2) AS YEAR,
count(CAUSE_OF_DEATH) AS COUNT_COD
FROM AMERICAN_DEATHS_ABROAD
WHERE CAUSE_OF_DEATH <> "suicide" AND COUNTRY IN ("Mexico", "Haiti", "Costa Rica", "Philippines", "Thailand", "Dominican Republic", "Jamaica", "Bahamas", "Afghanistan", "Honduras")
GROUP BY COUNTRY, YEAR
ORDER BY CASE
         WHEN COUNTRY = 'Mexico' then 1
         WHEN COUNTRY = "Haiti" then 2 
         WHEN COUNTRY = 'Costa Rica' then 3
         WHEN COUNTRY = 'Philippines' then 4
         WHEN COUNTRY = 'Thailand' then 5
         WHEN COUNTRY = 'Dominican Republic' then 6
         WHEN COUNTRY = "Jamaica" then 7 
         WHEN COUNTRY = 'Bahamas' then 8
         WHEN COUNTRY = 'Afghanistan' then 9
         WHEN COUNTRY = 'Honduras' then 10
         END ASC, YEAR DESC;
         
SELECT
COD.COUNTRY_NAME,
count(COUNTRY_NAME) AS COUNT_VISIT
FROM BTSORIGINUS ORI
LEFT JOIN COUNTRY_CODES COD
ON ORI.DEST_COUNTRY = COD.CODE
GROUP BY COD.COUNTRY_NAME
ORDER BY COUNT_VISIT DESC;

SELECT
*,
DEATH.COUNT_COD / VISIT.COUNT_VISIT AS DEATH_VISIT
FROM ANALYSIS_DEATH_ABROAD DEATH
INNER JOIN 
ANALYSIS_VISIT_ABROAD VISIT
ON DEATH.COUNTRY = VISIT.COUNTRY_NAME
WHERE DEATH.COUNT_COD > 20 AND VISIT.COUNT_VISIT > 20
ORDER BY DEATH_VISIT DESC         