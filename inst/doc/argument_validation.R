## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library("oeli")

## -----------------------------------------------------------------------------
match_arg(
  arg = "lo",
  choices = c("loooong", "else"),
  several.ok = FALSE,
  none.ok = FALSE
)

## -----------------------------------------------------------------------------
check_covariance_matrix(
  matrix(c(1, 2, 2, 1), nrow = 2) * -1
)

## -----------------------------------------------------------------------------
check_correlation_matrix(
  matrix(c(1, 0, 0, 0), nrow = 2)
)

## -----------------------------------------------------------------------------
check_correlation_matrix(
  matrix(c(1, 1, 0, 1), nrow = 2)
)

## -----------------------------------------------------------------------------
check_probability_vector(
  1:5 / sum(1:5),
  len = 4
)

