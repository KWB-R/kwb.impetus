#' Continuous x scale for months
#' 
#' @export
ggplot2_scale_x_continuous_12 <- function()
{
  ggplot2::scale_x_continuous(
    breaks = 1:12, 
    labels = 1:12, 
    minor_breaks = NULL
  )
}
