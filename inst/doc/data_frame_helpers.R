## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library("oeli")

## -----------------------------------------------------------------------------
df <- data.frame("label" = c("A", "B"), "number" = 1:10)
delete_data_frame_columns(df = df, column_names = "label")
delete_data_frame_columns(df = df, column_names = "number")
delete_data_frame_columns(df = df, column_names = c("label", "number"))

## -----------------------------------------------------------------------------
df <- data.frame("label" = c("A", "B"), "number" = 1:10)
group_data_frame(df = df, by = "label")
group_data_frame(df = df, by = "label", keep_by = FALSE)

