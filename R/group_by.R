#' Group by Messstellennummer, Dekade, Dekade_Label, Monat, Label
#' 
#' @param data data frame
#' @export
group_by_site_decade_month_label <- function(data) {
  data %>%
    dplyr::group_by(
      .data$Messstellennummer, 
      .data$Dekade,
      .data$Dekade_Label, 
      .data$Monat, 
      .data$Label
    )
}

#' Group by Messstellennummer, Jahr, Monat, Label
#' 
#' @param data data frame
#' @export
group_by_site_year_month_label <- function(data) {
  data %>%
    dplyr::group_by(
      .data$Messstellennummer, 
      .data$Jahr,
      .data$Monat, 
      .data$Label
    )
}

#' Group by Dekade, Dekade_Label, Monat, Label
#' 
#' @param data data frame
#' @export
group_by_decade_month_label <- function(data) {
  data %>%
    dplyr::group_by(
      .data$Dekade,
      .data$Dekade_Label, 
      .data$Monat, 
      .data$Label
    )
}

#' Group by Dekade_Label
#' 
#' @param data data frame
#' @export
group_by_decade_label <- function(data) {
  data %>%
    dplyr::group_by(.data$Dekade_Label)
}

#' Group by Jahr, Monat
#' 
#' @param data data frame
#' @export
group_by_year_month <- function(data) {
  data %>%
    dplyr::group_by(.data$Jahr, .data$Monat)
}
