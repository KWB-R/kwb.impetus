### Zufluesse Berlin
library(kwb.impetus)

if (FALSE) {
kwb.impetus::q_surface_water

surface_inflows <- kwb.impetus::q_surface_water %>%  
  dplyr::select(tidyselect::starts_with("mq.")) %>%  
  dplyr::summarise(dplyr::across(.fns = sum)) 
zufluesse <- surface_inflows %>% 
  tidyr::pivot_longer(names_to = "parameter",
                      values_to = "m3_per_second", 
                      cols = tidyselect::everything()) %>% 
  dplyr::mutate(million_m3.per_year =  .data$m3_per_second*365*3600*24 / 1000000,
                  parameter = .data$parameter %>% 
                  stringr::str_replace("mq.", "Mittlerer Oberflächenwasserzufluss (") %>% 
                  stringr::str_replace("_", "-") %>%  
                  stringr::str_c(")")) %>% 
  dplyr::mutate(referenz = "https://www.berlin.de/sen/uvk/_assets/umwelt/wasser-und-geologie/niedrigwasser/niedrigwasser_berlin_2018-2020.pdf#page=16")



### https://www.bundestag.de/resource/blob/700220/9e2b154d8c50f289702d6ee82cef0cbe/PPT-Socher-data.pdf#page=18
suempfungswaesser <- tibble::tibble(
    parameter = "Sümpfungswässer (Lausitzer Revier)",
    million_m3.per_year = 144,
    m3_per_second = m3_per_year_in_m3_per_second(.data$million_m3.per_year*1E6),
    referenz = "https://www.bundestag.de/resource/blob/700220/9e2b154d8c50f289702d6ee82cef0cbe/PPT-Socher-data.pdf#page=18"
  )

randbedingungen_extern <- list(Suempfungswaesser = suempfungswaesser,
                        Zufluesse = zufluesse 
                        ) %>% dplyr::bind_rows() %>% 
  dplyr::relocate(.data$parameter)

crs_target <- 4326

berlin <- kwb.fisbroker::read_wfs(dataset_id = "s_wfs_alkis_land") %>%  
  sf::st_transform(crs = crs_target)


### Water Balance (ABIMO 2017) from FIS-Broker 
gwneu2017 <- kwb.fisbroker::read_wfs(dataset_id = "s02_17gwneu2017") %>%
  sf::st_transform(crs = crs_target)

## ohne Strassenflaechen
sum(sf::st_area(gwneu2017)) 

## mit Strassenflaechen
sum(gwneu2017$flaeche) 


## Wasserflaechen 
area_water <- as.numeric(sf::st_area(berlin)) - sum(gwneu2017$flaeche) 

### potential evaporation (for Wasserflaechen)

dwd.1991_2017 <- kwb.impetus::dwd_berlin_monthly %>% 
  dplyr::filter(parameter %in% c("evapo_r", "evapo_p", "precipitation"),
                year >= 1991, 
                year <= 2017) %>% 
  dplyr::group_by(parameter, year) %>% 
  dplyr::summarise(value = sum(.data$mean)) %>%  
  dplyr::ungroup() %>%  
  dplyr::group_by(parameter) %>%  
  dplyr::summarise(value = mean(.data$value)) %>%  
  tidyr::pivot_wider(names_from = parameter, values_from = value)


## ABIMO Mass Balance Error 

## Regen, Unkorrigiert (x 1.09)
regen_unkor_mm <- sum(gwneu2017$regenja*gwneu2017$flaeche)/sum(gwneu2017$flaeche)

regen_kor_mm <- sum((gwneu2017$verdunstun+gwneu2017$row+gwneu2017$ri)*gwneu2017$flaeche)/sum(gwneu2017$flaeche)
regen_kor_mm

regen_korrektur_faktor <- regen_kor_mm/regen_unkor_mm

regen_kor_m3 <- regen_kor_mm / 1000 * sum(gwneu2017$flaeche)


regen <- tibble::tibble( 
  mm.per_year = round(regen_kor_mm,0),
  million_m3.per_year = m3_to_million_m3(regen_kor_m3),
  m3_per_second = m3_per_year_in_m3_per_second(regen_kor_m3)
  )


verdunstung_m3 <- sum(gwneu2017$verdunstun/1000*gwneu2017$flaeche)
verdunstung_m3 # m3/Jahr
m3_per_year_in_m3_per_second(verdunstung_m3) # m3/s

verdunstung_mm <- sum(gwneu2017$verdunstun*gwneu2017$flaeche)/sum(gwneu2017$flaeche)
verdunstung_mm # mm/Jahr

verdunstung <- tibble::tibble(
    mm.per_year = round(verdunstung_mm,0),
    million_m3.per_year = m3_to_million_m3(verdunstung_m3),
    m3_per_second = m3_per_year_in_m3_per_second(verdunstung_m3)
  )


oberflaechenabfluss_m3 <- sum(gwneu2017$row/1000*gwneu2017$flaeche)
oberflaechenabfluss_m3 # m3/Jahr
m3_per_year_in_m3_per_second(oberflaechenabfluss_m3) # m3/s

oberflaechenabfluss_mm <- sum(gwneu2017$row*gwneu2017$flaeche)/sum(gwneu2017$flaeche)
oberflaechenabfluss_mm # mm/Jahr

oberflaechenabfluss <- tibble::tibble(
  mm.per_year = round(oberflaechenabfluss_mm,0),
  million_m3.per_year = m3_to_million_m3(oberflaechenabfluss_m3),
  m3_per_second = m3_per_year_in_m3_per_second(oberflaechenabfluss_m3)
)


interflow_m3 <- sum((gwneu2017$ri-gwneu2017$ri_k)/1000*gwneu2017$flaeche)
interflow_mm <- sum((gwneu2017$ri-gwneu2017$ri_k)*gwneu2017$flaeche)/sum(gwneu2017$flaeche)

zwischenabfluss <- tibble::tibble(
  mm.per_year = round(interflow_mm,0),
  million_m3.per_year = m3_to_million_m3(interflow_m3),
  m3_per_second = m3_per_year_in_m3_per_second(interflow_m3)
)

gwn_m3 <- sum(gwneu2017$ri_k/1000*gwneu2017$flaeche)
gwn_mm <- sum(gwneu2017$ri_k*gwneu2017$flaeche)/sum(gwneu2017$flaeche)


gwn <- tibble::tibble(
  mm.per_year = round(gwn_mm,0),
  million_m3.per_year = m3_to_million_m3(gwn_m3),
  m3_per_second = m3_per_year_in_m3_per_second(gwn_m3)
)


wasserhaushalt_berlin <- dplyr::bind_rows(regen, 
                        verdunstung,  .id = "parameter") %>% 
  dplyr::bind_rows(oberflaechenabfluss, .id = "parameter") %>% 
  dplyr::bind_rows(zwischenabfluss, .id = "parameter") %>% 
  dplyr::bind_rows(gwn, .id = "parameter") %>% 
  dplyr::mutate(referenz = "https://fbinter.stadt-berlin.de/fb/berlin/service_intern.jsp?id=s02_17gwneu2017@senstadt&type=WFS&type=WFS")


wasserhaushalt_berlin$parameter <- c("Regen", 
                                     "Verdunstung", 
                                     "Oberflächenabfluss",
                                     "Zwischenabfluss", 
                                     "Grundwasserneubildung")


### Effektive Verdunstungsverluste ueber Wasserflaechen (Millionen m3/a)
### to do: do on monthly basis ! 
wasserbilanz_gewaesser <- tibble::tibble(
  verdunstung.mm = 775, # default Wert ABIMO Gewaesserverdunstung, 
  regen.mm = regen_kor_mm,
  wasserflaeche.m2 = area_water,
  verdunstung.m3_per_year = verdunstung.mm * wasserflaeche.m2 / 1000, 
  regen.m3_per_year = regen.mm * wasserflaeche.m2 / 1000,
  regen.m3_per_second = m3_per_year_in_m3_per_second(regen.m3_per_year),
  verdunstung.m3_per_second = m3_per_year_in_m3_per_second(verdunstung.m3_per_year)
) %>% 
  tidyr::pivot_longer(names_to = "parameter.einheit",
                      values_to = "value",
                      tidyselect::everything())

randbedingungen_intern.2021 <- tibble::tibble(
  trinkwasserfoerderung.million_m3 = 215,
  trinkwasserfoerderung.m3_per_second = m3_per_year_in_m3_per_second(.data$trinkwasserfoerderung.million_m3*1E6),
  abwassermenge.million_m3 = 260,
  abwassermenge.m3_per_second = m3_per_year_in_m3_per_second(.data$abwassermenge.million_m3*1E6),
  uferfiltratsanteil.prozent = 54, #https://www.bwb.de/de/assets/downloads/wvk2040_pk.pdf#page=5
  kuenstliche_grundwasseranreicherung.prozent = 14, #https://www.bwb.de/de/assets/downloads/wvk2040_pk.pdf#page=5
  landseitiges_grundwasser.prozent = 100 - .data$uferfiltratsanteil.prozent - kuenstliche_grundwasseranreicherung.prozent,
  uferfiltratsanteil.million_m3 = trinkwasserfoerderung.million_m3 * uferfiltratsanteil.prozent/100,
  uferfiltratsanteil.m3_per_second = m3_per_year_in_m3_per_second(.data$uferfiltratsanteil.million_m3*1E6),
  kuenstliche_grundwasseranreicherung.million_m3 = trinkwasserfoerderung.million_m3 * kuenstliche_grundwasseranreicherung.prozent/100,
  kuenstliche_grundwasseranreicherung.m3_per_second = m3_per_year_in_m3_per_second(.data$kuenstliche_grundwasseranreicherung.million_m3*1E6),
  landseitiges_grundwasser.million_m3 = trinkwasserfoerderung.million_m3 * landseitiges_grundwasser.prozent/100,
  landseitiges_grundwasser.m3_per_second = m3_per_year_in_m3_per_second(.data$landseitiges_grundwasser.million_m3*1E6)
) %>% 
  tidyr::pivot_longer(names_to = "parameter.einheit",
                      values_to = "value",
                      tidyselect::everything()) %>% 
  tidyr::separate(parameter.einheit, 
                  into = c("parameter", "einheit"), 
                  sep = "\\.") %>% 
  dplyr::arrange(.data$einheit, 
                 dplyr::desc(.data$value))
  
flows <- list(randbedingungen_extern = randbedingungen_extern, 
     wasserhaushalt_berlin = wasserhaushalt_berlin,
     wasserbilanz_gewaesser = wasserbilanz_gewaesser,
     randbedingungen_intern.2021 = randbedingungen_intern.2021)


openxlsx::write.xlsx(flows, "impetus_flows_v1.0.0.xlsx")
}

m3_to_million_m3 <- function (values) {
  round(values / 1000000, 1)
}
m3_per_year_in_m3_per_second <- function(values) {
  round(values / 365 / 24 / 3600,1)
}
