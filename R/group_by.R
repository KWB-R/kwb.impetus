#' Group by Messstellennummer, Decade, Decade_Label, Month, Label
#' 
#' @param data data frame
#' @export
#' @importFrom dplyr group_by
group_by_site_decade_month_label <- function(data) {
  data %>%
    dplyr::group_by(
      .data$Messstellennummer, 
      .data$Decade,
      .data$Decade_Label, 
      .data$Month, 
      .data$Label
    )
}

#' Group by Messstellennummer, Year, Month, Label
#' 
#' @param data data frame
#' @export
#' @importFrom dplyr group_by
group_by_site_year_month_label <- function(data) {
  data %>%
    dplyr::group_by(
      .data$Messstellennummer, 
      .data$Year,
      .data$Month, 
      .data$Label
    )
}

#' Group by Decade, Decade_Label, Month, Label
#' 
#' @param data data frame
#' @export
#' @importFrom rlang .data
group_by_decade_month_label <- function(data) {
  data %>%
    dplyr::group_by(
      .data$Decade,
      .data$Decade_Label, 
      .data$Month, 
      .data$Label
    )
}

#' Group by Dekade_Label
#' 
#' @param data data frame
#' @export
group_by_decade_label <- function(data) {
  data %>%
    dplyr::group_by(.data$Decade_Label)
}

#' Group by Year, Month
#' 
#' @param data data frame
#' @export
group_by_year_month <- function(data) {
  data %>%
    dplyr::group_by(.data$Year, .data$Month)
}
