## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library("oeli")

## ----print matrix-------------------------------------------------------------
print_matrix(x = 1, label = "single numeric")
print_matrix(x = LETTERS[1:26], label = "letters")
print_matrix(x = 1:3, coldots = 2)
print_matrix(x = matrix(rnorm(99), ncol = 1), label = "single column matrix")
print_matrix(x = matrix(1:100, nrow = 1), label = "single row matrix")
print_matrix(x = matrix(LETTERS[1:24], ncol = 6), label = "big matrix")
print_matrix(x = diag(5), coldots = 2, rowdots = 2, simplify = TRUE)

## ----matrix indices-----------------------------------------------------------
M <- diag(3)
matrix_indices(M)
matrix_indices(M, "M_")
matrix_indices(M, "M_", TRUE)

## ----insert matrix column-----------------------------------------------------
A <- diag(3)
x <- numeric(3)
insert_matrix_column(A, x, 0)
insert_matrix_column(A, x, 1)
insert_matrix_column(A, x, 2)
insert_matrix_column(A, x, 3)

