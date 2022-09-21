remotes::install_github("kwb-r/kwb.dwd")

library(kwb.impetus)

shape_obj <- kwb.dwd:::get_shape_of_german_region(name = "berlin")
shape_file <- "berlin.shp"

shape_obj %>% 
sf::st_as_sf() %>% 
sf::write_sf(shape_file)

### Plot to check if Berlin boundaries are plotted correctly.
### Set target CRS
crs_target <- 4326

shape_pt <- sf::st_read(shape_file) %>%
  sf::st_transform(crs = crs_target)

basemap <- shape_pt %>%
  leaflet::leaflet() %>%
  leaflet::addTiles() %>%
  leaflet::addProviderTiles(leaflet::providers$CartoDB.Positron) %>%
  leaflet::addPolygons(color = "red", fill = FALSE)

basemap

yearmonth_start <- "188101"
yearmonth_end <- "202208"

kwb.dwd:::list_monthly_grids_germany_asc_gz("x")

dwd_monthly_vars <- c(#"air temperature (mean)" = "air_temperature_mean"#,
                      "drought index" = "drought_index",
                      "evaporation, potential" = "evapo_p",
                      "evaporation, real" = "evapo_r",
                      "precipitation" = "precipitation",
                      "soil moisture" = "soil_moist",
                      "soil temperature (5 cm)" = "soil_temperature_5cm"
                      )

system.time(
  dwd_berlin_monthly_list <- stats::setNames(lapply(dwd_monthly_vars, function(dwd_var) {
  kwb.dwd::read_monthly_data_over_shape(
    file = shape_file,
    variable = dwd_var,
    from = yearmonth_start,
    to = yearmonth_end,
    quiet = TRUE
  )
}), nm = dwd_monthly_vars))


dwd_berlin_monthly <- dplyr::bind_rows(dwd_berlin_monthly_list, .id = "parameter")

dwd_berlin_monthly <- tibble::tibble(parameter_name = names(dwd_monthly_vars), 
               parameter = as.character(dwd_monthly_vars)) %>%  
  dplyr::left_join(dwd_berlin_monthly)


usethis::use_data(dwd_berlin_monthly, overwrite = TRUE)
