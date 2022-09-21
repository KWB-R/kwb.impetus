#' Group by Messstellennummer, Dekade, Dekade_Label, Monat, Label
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
      .data$Monat, 
      .data$Label
    )
}

#' Group by Messstellennummer, Jahr, Monat, Label
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

#' Group by Dekade, Dekade_Label, Monat, Label
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

#' Group by Jahr, Monat
#' 
#' @param data data frame
#' @export
group_by_year_month <- function(data) {
  data %>%
    dplyr::group_by(.data$Year, .data$Month)
}
