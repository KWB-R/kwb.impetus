## code to prepare `masterplan_measures` dataset goes here

## Data extracted manually from table in the following report: 
## Senatsverwaltung für Umwelt, Mobilität, Verbraucher- und Klimaschutz: Masterplan Wasser (Anlage 1 -Maßnahmensteckbriefe), 1. Bericht, Stand: 30.09.2022
## https://www.berlin.de/sen/uvk/_assets/umwelt/wasser-und-geologie/masterplan-wasser/masterplan-wasser-berlin.pdf
`%>%` <- magrittr::`%>%`

xlsx_path <- "inst/extdata/masterplan-wasser_2022-09-30_massnahmensteckbriefe.xlsx"

sheets <- readxl::excel_sheets(xlsx_path)

x <- stats::setNames(lapply(sheets, function(sheet) {
  readxl::read_xlsx(xlsx_path, sheet = sheet)
  }
  ), nm = sheets)

mwm <- x$topics %>% 
  dplyr::left_join(x$measures)

mwm_related_measures <- mwm %>%  
  tidyr::separate_rows("related_measure_ids", 
                       sep = "-") %>% 
  dplyr::rename("related_measure_id" = "related_measure_ids") %>% 
  dplyr::mutate("related_measure_id" = as.integer(.data$related_measure_id))

mwm_responsible_authorities <- mwm %>%  
  tidyr::separate_rows("responsible_authorities_ids", 
                       sep = "-") %>% 
  dplyr::rename("responsible_authorities_id" = "responsible_authorities_ids") %>% 
  dplyr::mutate("responsible_authorities_id" = as.integer(.data$responsible_authorities_id)) %>% 
  dplyr::left_join(x$authorities, 
                   by = c("responsible_authorities_id" = "authority_id"))


masterplan_measures.joined <- list(
  measures = mwm, 
  related_measures = mwm_related_measures,
  reference = x$reference,
  responsible_authorities = mwm_responsible_authorities
  )

masterplan_measures.raw <- x

usethis::use_data(masterplan_measures.raw, overwrite = TRUE)
usethis::use_data(masterplan_measures.joined, overwrite = TRUE)
