## code to prepare `q_surface_water` dataset goes here

## Data extracted manually from table in the following report: 
## https://www.berlin.de/sen/uvk/_assets/umwelt/wasser-und-geologie/niedrigwasser/niedrigwasser_berlin_2018-2020.pdf#page=16

q_surface_water <- tibble::tibble(
  fliessgewaesser = c(
    "Dahme",
    "Oder-Spree-Kanal",
    "Spree",
    "Havel",
    "Wuhle",
    "Fredersdorfer Mühlenfließ"
  ),
  pegel = c(
    "Neue Mühle UP",
    "Wernsdorf OP",
    "Große Tränke UP",
    "Borgsdorf",
    "Am Bahndamm",
    "Hegemeisterweg"
  ),
  mq.1991_2017 = c(9.13, 7.90, 12.30, 12.30, 0.51, 0.20),
  mnq.1991_2017 = c(0.69, 0.95, 3.04, 2.69, 0.23, 0.00),
  nq.1991_2017 = c(0.20, 0.54, 1.01, 1.70, 0.06, 0.00),
  nnq.value = c(0.03, 0.10, 1.01, 1.66, 0.06, 0.00),
  nnq.date = c(
    "1954-02-28",
    "1905-05-07",
    "2001-08-03",
    "2009-09-29",
    "2014-09-04",
    NA_character_
  ),
  mq.2018 = c(11.40, 5.44, 9.37, 16.90, 0.30, 0.00),
  mq.2019 = c(4.38, 2.95, 9.33, 6.97, 0.16, 0.00),
  mq.2020 = c(2.82, 2.64, 9.03, 7.71, 0.17, 0.00)
)

usethis::use_data(q_surface_water, overwrite = TRUE)
