library(magrittr)
crs_target <- 4326

ezg_paths <- archive::archive_extract(archive = "https://data.geobasis-bb.de/geofachdaten/Wasser/Hydrologie/ezg25.zip")
ezg_path_shp <- ezg_paths[grepl(pattern = ".*\\.shp$", ezg_paths)]

ezg <- sf::read_sf(ezg_path_shp) %>% 
  sf::st_transform(crs = crs_target)


berlin <-
  kwb.fisbroker::read_wfs(dataset_id = "s_wfs_alkis_land") %>%
  sf::st_transform(crs = crs_target)



efl <- sf::read_sf("C:/kwb/projects/impetus/SenUMVK/ArcEgmo/Übergabe_2021_05_05/SL4/Modellflaechen/efl.shp")  %>%
  sf::st_transform(crs = crs_target)


# efl %>%  
#   sf::st_make_valid() %>% 
#   dplyr::select(- geometry) %>% 
#   dplyr::group_by("EZG") %>% 
#   dplyr::summarise(area_sum = .data$AREA)


efl_berlin <- efl %>% 
  ### issue: "Loop 0 is not valid: Edge x has duplicate vertex with edge y" 
  ### fix: https://github.com/r-spatial/sf/issues/1762#issuecomment-1275062137
  sf::st_make_valid() %>%
  sf::st_intersection(berlin)


ezg <- unique(efl_berlin$EZG)[!is.na(unique(efl_berlin$EZG))]

meta_ezg <- tibble::tibble(
  EZG = c(NA_character_, ezg), 
  EZG_color = c("#FFFFFFFF", rainbow(n = length(ezg)))
)


efl_berlin[, c("EZG", "geometry")] %>%  
  dplyr::left_join(meta_ezg) %>% 
  leaflet::leaflet() %>%
  leaflet::addTiles() %>%
  leaflet::addProviderTiles(leaflet::providers$CartoDB.Positron) %>%
  leaflet::addPolygons(stroke = FALSE,
                       fillColor = ~EZG_color) %>% 
  leaflet::addLegend(
    position = "topright",
    colors = meta_ezg$EZG_color,
    labels = unique(meta_ezg$EZG),
    title = "Waterworks Catchments")




### GWN_SL4.txt # 2.2GB # ~ 4s
system.time(gwn <- data.table::fread("C:/kwb/projects/impetus/SenUMVK/ArcEgmo/Übergabe_2021_05_05/SL4/Monatswerte_SL4/GWN_SL4.txt", 
                         sep = "\t"))

## data.table::melt # < 1s
system.time(gwn_tidy <-  data.table::melt(gwn, id.vars = "KEN", 
                                          variable.name = "monthyear"))  

# tidyr::separate(col = "monthyear", 
#                 into = c("month", "year"), 
#                 sep = ".",
#                 remove = FALSE)


tmp <- data.table::fread(text = as.character(gwn_tidy$monthyear), sep = ".", header = FALSE)

system.time(gwn_tidy <- gwn_tidy[, c("month", "year") := data.table::tstrsplit(monthyear, 
                                                                               split = ".", 
                                                                               type.convert = TRUE)]
            )
  
nrow(gwn_tidy)


## dplyr::pivot_longer # < 7s
system.time(gwn_tidy2 <- gwn %>%  
  tidyr::pivot_longer(names_to = "monthyear", 
                      values_to = "value",
                      - "KEN"))
nrow(gwn_tidy2)


preci <- kwb.fisbroker::read_wfs(dataset_id = "s_04_08_1lniederschl_bl_8110") %>% 
  sf::st_transform(crs = crs_target)


binpal <- leaflet::colorNumeric("RdYlBu", preci$regnie_8110_wawi_jahr, 10)

preci[, c("regnie_8110_wawi_jahr","geom")] %>%  
  leaflet::leaflet() %>%
  leaflet::addTiles() %>%
  leaflet::addProviderTiles(leaflet::providers$CartoDB.Positron) %>%
  leaflet::addPolygons(stroke = FALSE, 
                       fillColor = ~binpal(regnie_8110_wawi_jahr), 
                       fill = TRUE) %>% 
  leaflet::addLegend(
    position = "topright",
    pal = binpal, 
    values = ~regnie_8110_wawi_jahr,
    title = "Rain (mm/a)")