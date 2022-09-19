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
#' #### R code used for creation of "dwd_berlin_monthly.rds"
#' ############################################################################
#' 
#' remotes::install_github("kwb-r/kwb.dwd@@dev")
#' 
#' library(kwb.impetus)
#' 
#' yearmonth_start <- "188101"
#' yearmonth_end <- paste0(
#'   format(Sys.Date(), "%Y"),
#'   sprintf("%02d", as.numeric(format(Sys.Date(), "%m")) - 1L)
#' )
#'                         
#' system.time(
#'   dwd_berlin_precipitation <- kwb.dwd::load_precipitation_berlin(
#'     from = yearmonth_start,
#'     to = yearmonth_end
#'   )
#' )
#'
#' system.time(
#'   dwd_berlin_evapo_p <- kwb.dwd::load_potential_evaporation_berlin(
#'     from = yearmonth_start,
#'     to = yearmonth_end
#'   )
#' )
#'
#' add_parameter_and_url <- function(data, parameter, subdir) {
#'   dplyr::mutate(
#'     data,
#'     parameter = parameter, 
#'     url = sprintf(
#'       "%s/grids_germany/monthly/%s/%s", 
#'       kwb.dwd:::dwd_url_climate_dir(), subdir, .data$file
#'     )
#'   )
#' }
#'
#' dwd_berlin_monthly <- dplyr::bind_rows(
#'   add_parameter_and_url(
#'     dwd_berlin_precipitation,
#'     parameter = "precipitation",
#'     subdir = "precipitation"
#'   ),
#'   add_parameter_and_url(
#'     dwd_berlin_evapo_p,
#'     parameter = "potential evaporation",
#'     subdir = "evapo_p"
#'   )
#' )
#'
#' usethis::use_data(dwd_berlin_monthly, overwrite = TRUE)
#' } 
"dwd_berlin_monthly"