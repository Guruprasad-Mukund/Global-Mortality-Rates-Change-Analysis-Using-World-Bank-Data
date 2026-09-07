# Intermediate Data

This folder contains datasets transformed from the original World Bank files into long format via Excel PowerQuery's unpivoting functionality. Each dataset was reshaped so that every row represents one country-year observation. These intermediate tables were then used in SQL to create the final merged dataset for analysis.

Steps followed:
1. Open the World Bank dataset in Excel/Power Query.
2. Keep identifiers such as country_name and country_code.
3. Unpivot the year columns so that the years became rows.
4. Rename:
Attribute → year
Value → the relevant variable, such as pop_65_plus, gdp_per_capita, etc.
6. Load the transformed long-format data back into Excel and save it as CSV.
