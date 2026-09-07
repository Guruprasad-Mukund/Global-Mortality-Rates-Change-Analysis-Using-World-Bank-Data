SELECT country_code,year,COUNT(*)
FROM pop_age_65_plus
GROUP BY country_code,year
HAVING COUNT(*) > 1;

SELECT country_code,year,COUNT(*)
FROM gdp_per_capita
GROUP BY country_code,year
HAVING COUNT(*) > 1;

SELECT country_code,year,COUNT(*)
FROM death_rate
GROUP BY country_code,year
HAVING COUNT(*) > 1;

SELECT country_code,year,COUNT(*)
FROM current_health_expenditure_per_capita
GROUP BY country_code,year
HAVING COUNT(*) > 1;

SELECT * 
FROM pop_age_65_plus
WHERE country_code IS NULL 
OR year IS NULL;

SELECT * 
FROM gdp_per_capita
WHERE country_code IS NULL 
OR year IS NULL;

SELECT * 
FROM death_rate
WHERE country_code IS NULL 
OR year IS NULL;

SELECT * 
FROM current_health_expenditure_per_capita
WHERE country_code IS NULL 
OR year IS NULL;

SELECT COUNT(*) AS total_rows,
COUNT(country_code) AS nonnull_country_code,
COUNT(year) AS non_null_year,
COUNT(pop_65_plus) AS nonnull_pop_65_plus,
COUNT(*) - COUNT(pop_65_plus) AS missing_pop65

FROM pop_age_65_plus;


SELECT COUNT(*) AS total_rows,
COUNT(country_code) AS nonnull_country_code,
COUNT(year) AS non_null_year,
COUNT(gdp_per_capita) AS nonnull_gdp_per_capita,
COUNT(*) - COUNT(gdp_per_capita) AS missing_gdp_per_capita

FROM gdp_per_capita;

SELECT COUNT(*) AS total_rows,
COUNT(country_code) AS nonnull_country_code,
COUNT(year) AS non_null_year,
COUNT(death_rate) AS nonnull_death_rate,
COUNT(*) - COUNT(death_rate) AS missing_death_rate

FROM death_rate;


SELECT COUNT(*) AS total_rows,
COUNT(country_code) AS nonnull_country_code,
COUNT(year) AS non_null_year,
COUNT(current_health_expenditure_per_capita) AS nonnull_current_health_expenditure_per_capita,
COUNT(*) - COUNT(current_health_expenditure_per_capita) AS missing_current_health_expenditure_per_capita

FROM current_health_expenditure_per_capita;


CREATE VIEW combined_data AS
SELECT
    p.country_code,
    p.country_name,
    p.year,
    p.pop_65_plus,
    g.gdp_per_capita,
    h.current_health_expenditure_per_capita,
    d.death_rate
FROM pop_age_65_plus p
LEFT JOIN gdp_per_capita g
    ON p.country_code = g.country_code
   AND p.year = g.year
LEFT JOIN current_health_expenditure_per_capita h
    ON p.country_code = h.country_code
   AND p.year = h.year
LEFT JOIN death_rate d
    ON p.country_code = d.country_code
   AND p.year = d.year;

SELECT * FROM combined_data LIMIT 10;

SELECT DISTINCT year
FROM combined_data
ORDER BY year;

SELECT COUNT(*) FROM combined_data;

SELECT
    COUNT(*) AS total_rows,
    COUNT(gdp_per_capita) AS nonnull_gdp,
    COUNT(current_health_expenditure_per_capita) AS nonnull_health,
    COUNT(pop_65_plus) AS nonnull_pop65,
    COUNT(death_rate) AS nonnull_death
FROM combined_data;


SELECT COUNT(*) AS complete_cases
FROM combined_data
WHERE gdp_per_capita IS NOT NULL
AND current_health_expenditure_per_capita IS NOT NULL
AND pop_65_plus IS NOT NULL
AND death_rate IS NOT NULL;


SELECT

year,
COUNT(*) AS total_rows,
COUNT(gdp_per_capita) AS nonnull_gdp,
COUNT(current_health_expenditure_per_capita) AS nonnull_health
FROM combined_data
GROUP BY year
ORDER BY year;

CREATE VIEW valid_rows AS
SELECT * 
FROM combined_data
WHERE YEAR in (2000,2019)
AND gdp_per_capita IS NOT NULL
AND current_health_expenditure_per_capita IS NOT NULL
AND pop_65_plus IS NOT NULL;


CREATE VIEW balanced_panel AS 
SELECT * 
FROM valid_rows
WHERE country_code IN (
SELECT country_code
FROM valid_rows
GROUP BY country_code
HAVING COUNT(DISTINCT year) = 2
);

SELECT COUNT(DISTINCT country_code) FROM balanced_panel;


CREATE VIEW balanced_panel_features AS 
SELECT 
*,
LN(gdp_per_capita) AS log_gdp,
LN(current_health_expenditure_per_capita) AS log_health
FROM balanced_panel
WHERE gdp_per_capita > 0
AND current_health_expenditure_per_capita > 0;

CREATE VIEW country_changes AS 
SELECT

a.country_code,
a.death_rate AS death_2000,
b.death_rate AS death_2019,
b.death_rate - a.death_rate AS death_change,

a.gdp_per_capita AS gdp_2000,
b.gdp_per_capita AS gdp_2019,
b.gdp_per_capita - a.gdp_per_capita AS gdp_change,

a.current_health_expenditure_per_capita AS health_2000,
b.current_health_expenditure_per_capita AS health_2019,
b.current_health_expenditure_per_capita - a.current_health_expenditure_per_capita AS health_change,

a.pop_65_plus AS pop65_2000,
b.pop_65_plus AS pop_65_2019,
b.pop_65_plus - a.pop_65_plus AS pop_65_change

FROM balanced_panel a
JOIN balanced_panel b
ON a.country_code = b.country_code
WHERE a.year = 2000
AND b.year = 2019;

