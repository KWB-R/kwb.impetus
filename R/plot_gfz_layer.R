#' Plot GFZ Model Raster Layer 
#'
#' @param layer a layer as retrieved by \code{\link{read_gfz_layers}}
#'
#' @return plot raster layer
#' @export
#'
#' @importFrom sf st_transform
#' @importFrom leaflet addLegend addProviderTiles addTiles colorNumeric leaflet
#' @importFrom leafem addStarsImage 
plot_gfz_layer <- function(layer) {
  
  layer_name <- deparse(substitute(layer))
  crs_target <- 4326
  
  r <- layer %>%
    sf::st_transform(crs = crs_target)
  
  vals <- unique(layer[[1]])
  
  pal <- leaflet::colorNumeric(palette = c("#0C2C84", "#41B6C4", "#FFFFCC"), 
                               domain = vals,
                               na.color = "transparent")
  
  leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addProviderTiles(leaflet::providers$CartoDB.Positron) %>% 
    leafem::addStarsImage(x = r, 
                          colors = pal, 
                          opacity = 0.8) %>%
    leaflet::addLegend(position = "topright",
                       pal = pal, 
                       values = vals,
                       title = layer_name)
}
