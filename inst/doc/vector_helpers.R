## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library("oeli")

## ----subset type 1------------------------------------------------------------
v <- 1:4
subsets(v)

## ----subset type 2------------------------------------------------------------
v <- 1:4
subsets(v, n = 2:3)

## ----chunk vectors type 1-----------------------------------------------------
x <- 1:6
chunk_vector(x, n = 3)

## ----chunk vectors type 2-----------------------------------------------------
chunk_vector(x, n = 3, type = 2)

## ----chunk vectors uneven-----------------------------------------------------
x <- 1:7
chunk_vector(x, n = 3)
chunk_vector(x, n = 3, type = 2)

## ----chunk vectors strict-----------------------------------------------------
try(chunk_vector(1:7, n = 3, strict = TRUE))

## ----vector occurrence--------------------------------------------------------
x <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
vector_occurrence(x, "first")
vector_occurrence(x, "last")

## ----vector occurrence unique-------------------------------------------------
unique(x)

