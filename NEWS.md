# kwb.impetus 0.0.0.9000

**Data Analysis**: 

* Add workfow for [Infographic (KWB Annual Report)](../articles/infographic_annual-report.html)
that will be published in the upcoming KWB annual report 2021/2022.

* Added three workflows for data analysis (`monthly` values were grouped to  `decades`, 
and for each month the `mean` as well as `5%` and `95%` confidence intervals are given). 
The three workflows are based on open-data from 

- [Wasserportal Berlin](https://wasserportal.berlin.de) covered data period starts 
on `1970-01-01` up to the recent year. Time resolution varied but are mostly `daily` 
for quantitative `surface/groundwater` monitoring stations. These were summarized to 
`monthly means`.

- [Deutscher Wetterdienst (DWD)](https://opendata.dwd.de/) with spatially averaged 
parameters (e.g. `precipitation`, evaporation: `real` and `potential` for Berlin 
(see [DWD (Grid Data)](../articles/dwd.html)). The longest time period with data  
is available for `precipitation`, which starts on `1881-01-01` and ends on `2022-08-31`.
For more details checkout the dataset `dwd_berlin_monthly` which is provided 
within this R package. In addition also a 
[DWD (Climatic Water Balance)](../articles/dwd_climatic-water-balance.html) workflow 
is available by subtracting `evaporation, real/potential` from `precipitation` 
(based on [DWD (Grid Data)](../articles/dwd.html)).

**Other**: 

* Added a `NEWS.md` file to track changes to the package.

* see https://style.tidyverse.org/news.html for writing a good `NEWS.md`


