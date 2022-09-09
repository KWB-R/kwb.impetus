[![R-CMD-check](https://github.com/KWB-R/kwb.impetus/workflows/R-CMD-check/badge.svg)](https://github.com/KWB-R/kwb.impetus/actions?query=workflow%3AR-CMD-check)
[![pkgdown](https://github.com/KWB-R/kwb.impetus/workflows/pkgdown/badge.svg)](https://github.com/KWB-R/kwb.impetus/actions?query=workflow%3Apkgdown)
[![codecov](https://codecov.io/github/KWB-R/kwb.impetus/branch/main/graphs/badge.svg)](https://codecov.io/github/KWB-R/kwb.impetus)
[![Project Status](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/kwb.impetus)]()
[![R-Universe_Status_Badge](https://kwb-r.r-universe.dev/badges/kwb.impetus)](https://kwb-r.r-universe.dev/)

R Package with Functions used in Project IMPETUS.

## Installation

For installing the latest release of this R package run the following code below:

```r
# Enable repository from kwb-r
options(repos = c(
  kwbr = 'https://kwb-r.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))
  
# Download and install 'kwb.impetus in R
install.packages('kwb.impetus')

# Browse the 'kwb.impetus manual pages
help(package = 'kwb.impetus')
```
## Usage 

Checkout the `Data Analysis` workflows for the Berlin case study site: 

- [Deutscher Wetterdienst (DWD)](articles/dwd.html) using monthly open-data on 
`precitiptation` (`1881-01` - `2022-08`) and `potential evaporation` 
(`1991-01` - `2022-08`). For details on how this dataset was pre-processed, see 
here: [dwd_berlin_monthly](reference/dwd_berlin_monthly.html) and

- [Wasserportal](articles/wasserportal.html) for `surface water level/flow` and 
`groundwater level` from Berlin (https://wasserportal.berlin.de).
