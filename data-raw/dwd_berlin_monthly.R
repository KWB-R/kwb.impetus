remotes::install_github("kwb-r/kwb.dwd@dev")

library(kwb.impetus)

yearmonth_start <- "188101"
yearmonth_end <- paste0(format(Sys.Date(), "%Y"), 
                        sprintf("%02d", 
                                as.numeric(format(Sys.Date(), "%m"))-1))

system.time(dwd_berlin_precipitation <- kwb.dwd::load_precipitation_berlin(
  from = yearmonth_start,
  to = yearmonth_end)
)


system.time(dwd_berlin_potentialevaporation <- kwb.dwd::load_potential_evaporation_berlin(
  from = yearmonth_start,
  to = yearmonth_end)
)

dwd_berlin_monthly <- dwd_berlin_precipitation %>%  
  dplyr::mutate(parameter = "precipitation", 
                url = sprintf("%s/grids_germany/monthly/%s/%s", 
                              kwb.dwd:::dwd_url_climate_dir(),
                              "precipitation",
                              .data$file)) %>%
  dplyr::bind_rows(
    dwd_berlin_potentialevaporation %>% 
      dplyr::mutate(parameter ="potential evaporation",
                    url = sprintf("%s/grids_germany/monthly/%s/%s", 
                                  kwb.dwd:::dwd_url_climate_dir(),
                                  "evapo_p",
                                  .data$file)))
  
usethis::use_data(dwd_berlin_monthly, overwrite = TRUE)
