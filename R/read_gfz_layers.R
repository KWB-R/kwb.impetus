#' Reads a single GFZ Model Layer
#'
#' @param  path path to GFZ Model Layer 
#' @param as_raster convert to raster (default: TRUE)
#'
#' @return imported layer file 
#' @export
#'
#' @importFrom readr read_delim
#' @importFrom sf st_as_sf
#' @importFrom stars st_rasterize

read_gfz_layer <- function(path, as_raster) {
  
  dat <- readr::read_delim(path, delim = " ", col_types = "d") %>% 
    sf::st_as_sf(coords = c("x", "y"), 
                 crs = 31468 # DHDN / 3-degree Gauss-Kruger zone 4
    )
  
  if(as_raster == FALSE) {
    return(dat)
  }
  
  dat %>%
      stars::st_rasterize() 
  
}


#' Reads multiple GFZ Model Layers
#'
#' @param  dir_model_data path to GFZ Model Layer Data as retrieved by 
#' [download_gfz_model()] 
#' @param as_raster convert to raster (default: TRUE)
#' @param dbg print debug messaages (default: TRUE)
#' @return imported layer files 
#' @export
#' 
#' @importFrom kwb.utils catAndRun removeExtension 
#' @importFrom stringr str_remove
#' @importFrom stats setNames
read_gfz_layers <- function(dir_model_data,
                            type = "elevation", 
                            as_raster = TRUE, 
                            dbg = TRUE) {
  
  paths <- list.files(path = dir_model_data, 
                      pattern = ".dat$",
                      full.names = TRUE)
  
  stopifnot(length(paths) > 0)
  
  paths_sel <- paths[stringr::str_detect(paths, pattern = type)]
  
  names_sel <- kwb.utils::removeExtension(basename(paths_sel)) %>% 
    stringr::str_remove(pattern = sprintf("_%s", type))
  
  stats::setNames(lapply(paths_sel, function(path) {
    
    kwb.utils::catAndRun(messageText = sprintf("Reading (%d/%d): '%s'", 
                                               which(paths_sel %in% path),
                                               length(paths_sel), 
                                               path), 
                         expr = {
                           read_gfz_layer(path, as_raster) 
                         },
                         dbg = dbg)
  }), nm = names_sel)
}
