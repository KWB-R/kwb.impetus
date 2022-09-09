#' DWD Dataset (Precipitation and Potential Evaporation) Averaged for Berlin 
#'
#' A dataset containing the precipitation and potential 
#' diamonds.
#'
#' @format A data frame with 53940 rows and 10 variables:
#' \describe{
#'   \item{file}{name of raw data file}
#'   \item{year}{year}
#'   \item{month}{month}
#'   \item{mean}{spatial mean value for month}
#'   \item{sd}{spatial standard deviation value for month}
#'   \item{min}{spatial minimum value for month}
#'   \item{max}{spatial maximum value for month}
#'   \item{n_values}{number of 1x1km2 grids used for spatial statistics calculation}
#'   \item{parameter}{parameter name}
#'   \item{url}{full url to raw data file}
#' }
#' @examples 
#' \dontrun{
#' ############################################################################
#' #### R code used for creation of "dwd_berlin_monthly.rds§ 
#' ############################################################################
#' 
#' remotes::install_github("kwb-r/kwb.dwd@dev")
#' 
#' library(kwb.impetus)
#' 
#' yearmonth_start <- "188101"
#' yearmonth_end <- paste0(format(Sys.Date(), "%Y"),
#'                         sprintf("%02d", 
#'                         as.numeric(format(Sys.Date(), "%m"))-1))
#'                         
#'system.time(dwd_berlin_precipitation <- kwb.dwd::load_precipitation_berlin(
#'from = yearmonth_start,
#'to = yearmonth_end)
#')
#'
#'system.time(dwd_berlin_potentialevaporation <- kwb.dwd::load_potential_evaporation_berlin(
#'from = yearmonth_start,
#'to = yearmonth_end)
#')
#'
#'dwd_berlin_monthly <- dwd_berlin_precipitation %>%  
#'dplyr::mutate(parameter = "precipitation", 
#'url = sprintf("%s/grids_germany/monthly/%s/%s", 
#'kwb.dwd:::dwd_url_climate_dir(),
#'"precipitation",
#'.data$file)) %>%
#'dplyr::bind_rows(
#'dwd_berlin_potentialevaporation %>%
#'dplyr::mutate(parameter ="potential evaporation",
#'url = sprintf("%s/grids_germany/monthly/%s/%s",
#'kwb.dwd:::dwd_url_climate_dir(),
#'"evapo_p",
#'.data$file)))
#'
#'usethis::use_data(dwd_berlin_monthly, overwrite = TRUE)
#' } 
"dwd_berlin_monthly"