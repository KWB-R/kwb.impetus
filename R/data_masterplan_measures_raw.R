#' Masterplan Wasser Measures Factsheets: "Raw" 
#'
#' Data manually extracted from Annnex I of Masterplan Wasser (status: 2022-09-30)
#' and saved in multiple sheets within spreadsheet 
#' "inst/extdata/inst/extdata/masterplan-wasser_2022-09-30_massnahmensteckbriefe.xlsx"),
#' data import documented in R script "data-raw/masterplan_measures.R"). Additional 
#' data-cleaning was performed (e.g. added "_id" columns) in order to enable the 
#' linking of the different sheets
#' 
#' @format A list with four elements, each containing a tibble:
#' \describe{
#'   \item{reference}{tibble with reference information}
#'   \item{topics}{tibble with topics for linking the "measures"}
#'   \item{measures}{tibble with information of measures}
#'   \item{authorities}{tibble with information of authorities responsible for
#'   the different "measures"}
#' }
#' @references Senatsverwaltung für Umwelt, Mobilität, Verbraucher- und Klimaschutz: 
#' Masterplan Wasser (Anlage 1 -Maßnahmensteckbriefe), 1. Bericht, Stand: 30.09.2022 
#' \url{https://www.berlin.de/sen/uvk/_assets/umwelt/wasser-und-geologie/masterplan-wasser/masterplan-wasser-berlin.pdf}
#' @examples 
#' kwb.impetus::masterplan_measures.raw
#' 
"masterplan_measures.raw"

