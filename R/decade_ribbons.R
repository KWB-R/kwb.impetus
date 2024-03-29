#' ggplot2 ribbon between q05 and q95
#' 
#' @param alpha passed to \code{\link[ggplot2]{geom_ribbon}}
#' @export
#' @importFrom ggplot2 aes_string geom_ribbon
decade_ribbons <- function(alpha = 0.1) {
  ggplot2::geom_ribbon(
    ggplot2::aes_string(
      ymin = "q05", 
      ymax = "q95", 
      fill = "Decade_Label"
    ), 
    alpha = alpha
  )
}
