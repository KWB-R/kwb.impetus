#' Download GFZ Model Layers
#'
#' @param target_dir target directory to extract files (default: tempdir())
#'
#' @return extracts GFZ model layers in target directory
#' @export
#' @importFrom kwb.utils resolve
#' @importFrom archive archive_extract
download_gfz_model <- function(target_dir = tempdir()) {


paths_list <- list(
  base_url = "https://datapub.gfz-potsdam.de/download/10.5880.GFZ.4.5.2020.005nuirg",
  dataset = "<base_url>/2020-005_Frick-et-al_Berlin-Model_data.zip"
)

paths <- kwb.utils::resolve(paths_list)


archive::archive_extract(archive = paths$dataset, 
                         dir = target_dir)

}