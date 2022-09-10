#' round to decade
#' @description rounds to next decade if end year is >=5 or floors to previous 
#' decade if end year <5.
#' @param values year
#'
#' @return decade
#' @export
#'
#' @examples
#' round_to_decade(2000:2020)
round_to_decade <- function(values) {
  unlist(lapply(values, function(value) {
    decade <- value - value %% 10 
    if (value %% 10 >= 5) {
      decade <- decade + 10
    }
    decade
  }))
}

#' floor to decade
#' @description floors to previous decade.
#' @param value year
#'
#' @return decade
#' @export
#'
#' @examples
#' floor_decade(2000:2020)
floor_decade <- function(value) { 
  value - value %% 10 
}

#' ggplot2: scale fill decades
#'
#' @param decades decades
#' @param ... additional arguments passed to xxx
#'
#' @return re-scales ggplot2
#' @importFrom stats setNames
#' @export
#' @noRd
#' @noMd
scale_fill_decades <- function(decades, ...){
  ggplot2:::manual_scale(
    'fill', 
    values = stats::setNames(decades$values, decades$names), 
    ...
  )
}


#' ggplot2: scale color decades
#'
#' @param decades decades
#' @param ... additional arguments passed to xxx 
#'
#' @return re-scales ggplot2
#' @export
#' @noRd
#' @noMd
scale_color_decades <- function(decades, ...){
  ggplot2:::manual_scale(
    'color', 
    values = setNames(decades$values, 
                      decades$names), 
    ...
  )
}