#' Masterplan Wasser Measures Factsheets: "Joined" 
#'
#' Based on [masterplan_measures.raw], but joining data of different sheets. 
#' For details see R script "data-raw/masterplan_measures.R"). 
#' 
#' @format A list with four elements, each containing a tibble:
#' \describe{
#'   \item{reference}{tibble with reference information, where "raw" data was 
#'   extracted from}
#'   \item{measures}{tibble with "topics" sheet joined with "measures" sheet}
#'   \item{related_measures}{tibble with "measures" tibble, but with one row for 
#'   each "related_measure"}
#'   \item{responsible_authorities}{tibble with "measures" tibble, but with one 
#'   row for each "responsible_authority" for each measure}
#' }
#' @references Senatsverwaltung für Umwelt, Mobilität, Verbraucher- und Klimaschutz: 
#' Masterplan Wasser (Anlage 1 -Maßnahmensteckbriefe), 1. Bericht, Stand: 30.09.2022 
#' \url{https://www.berlin.de/sen/uvk/_assets/umwelt/wasser-und-geologie/masterplan-wasser/masterplan-wasser-berlin.pdf}
#' @examples 
#' kwb.impetus::masterplan_measures.joined
#' 
"masterplan_measures.joined"

