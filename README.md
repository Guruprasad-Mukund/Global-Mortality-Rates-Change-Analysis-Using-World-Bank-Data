# World Bank Global Mortality Analysis

## Overview
This project investigates changes in mortality rates across countries
between 2000 and 2019 using World Bank data.

## Research Question
How did mortality rates change across countries from 2000 to 2019,
and how were those changes associated with changes in GDP per capita,
health expenditure per capita, and the percentage of the population
aged 65+?

## Data
Four World Bank datasets:
- GDP per capita
- Health expenditure per capita
- Population age 65+
- Mortality rate

## Data Preparation
The original World Bank datasets were transformed from wide to long
format using Excel Power Query. The resulting datasets were imported
into PostgreSQL, validated, and joined using country and year
identifiers.

The final analysis compares country-level changes between 2000 and 2019.

## Data Validation

Data-quality checks were performed throughout the preparation process to verify
year selections, joins, and derived variables before statistical analysis.

One inconsistency in the GDP per capita data was identified during validation,
traced to an incorrect comparison year, corrected, and the affected analysis
was rerun.

Additional troubleshooting notes are available in the validation/ folder.

## Methodology
- Data cleaning and integration in SQL
- Exploratory analysis in Python
- Correlation analysis
- Data visualization
- Simple and multiple linear regression
- Regression diagnostics

## Model Assumptions & Diagnostics

OLS models were evaluated for linearity and constant error variance using
residual plots. Diagnostic plots showed evidence of nonlinearity for some
specifications and heteroskedasticity for others, indicating that the standard
OLS assumptions were not fully satisfied.

Model performance was evaluated using p-values, R-squared, and adjusted
R-squared. Adjusted R-squared was emphasized when comparing multivariable and
polynomial models because it accounts for additional model complexity.

A 5% significance level was used for statistical hypothesis tests. Polynomial
specifications were evaluated based on the significance of higher-order terms
and whether they produced meaningful improvements in adjusted R-squared.

## Key Findings

- Changes in the percentage of the population aged 65+ had the strongest
  relationship with changes in mortality rates, with a correlation of
  approximately 0.61.

- A simple linear regression using elderly population change explained
  approximately 38% of the cross-country variation in mortality-rate changes,
  outperforming the other single-variable specifications.

- Adding GDP growth to the elderly-population model produced only a small
  improvement in explanatory power, while GDP was not statistically significant.

- More complex nonlinear specifications did not materially outperform the
  simple linear relationship, supporting the simpler model for interpretation.

## Limitations

- The analysis identifies associations rather than causal relationships.
  Omitted variables, such as healthcare quality, may be associated with both
  population aging and mortality-rate changes, creating potential confounding.

- The preferred simple linear model explains roughly 38% of the variation in
  mortality-rate changes, indicating that substantial variation is driven by
  factors not included in the model.

## Technologies
Python | pandas | SQL | PostgreSQL | Excel | Power Query |
Matplotlib | Seaborn | plotly | statsmodels | numpy

## Repository Structure
- data/ — raw, intermediate, and processed datasets
- sql/ — SQL queries and annotated SQL documentation
- notebooks/ — exploratory and regression analysis
- reports/ — final written report
- presentation/ — final project presentation
