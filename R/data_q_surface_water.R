#' Surface Water Flows (from Niedrigwasserbericht 2018-2020 by SenUVK Berlin) 
#'
#' Extracted parts of table on page 16 from Niedrigwasserbericht 2018-2020 by 
#' SenUVK Berlin. Contains only flows from `inflows` to Berlin (i.e. no 
#' data from `Sophienwerder` and `Muehlendammschleuse` ware imported) 
#'
#' @format A data frame with 6 rows and 10 variables:
#' \describe{
#'   \item{fliessgewaesser}{name of surface water}
#'   \item{pegel}{name of monitoring station}
#'   \item{mq.1991_2017}{MQ for period 1991-2017 (m3/s))}
#'   \item{mnq.1991_2017}{MQ for period 1991-2017 (m3/s)}
#'   \item{nq.1991_2017}{MQ for period 1991-2017 (m3/s))}
#'   \item{nnq.value}{NNQ value (m3/s)}
#'   \item{nnq.date}{Date of nnq.value (NA if "often" !)}
#'   \item{mq.2018}{MQ of year 2018 (m3/s)}
#'   \item{mq.2019}{MQ of year 2019 (m3/s)}
#'   \item{mq.2020}{MQ of year 2020 (m3/s)}
#' }
#' @references \url{https://www.berlin.de/sen/uvk/_assets/umwelt/wasser-und-geologie/niedrigwasser/niedrigwasser_berlin_2018-2020.pdf#page=16}
#' @examples 
#' kwb.impetus::q_surface_water
#' 
"q_surface_water"
