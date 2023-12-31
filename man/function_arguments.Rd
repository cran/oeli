% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/function_helpers.R
\name{function_arguments}
\alias{function_arguments}
\title{Get function arguments}
\usage{
function_arguments(f, with_default = TRUE, with_ellipsis = TRUE)
}
\arguments{
\item{f}{A \code{function}.}

\item{with_default}{Either \code{TRUE} to include function arguments that have default values,
or \code{FALSE} else.}

\item{with_ellipsis}{Either \code{TRUE} to include the \code{"..."} argument if present,
or \code{FALSE} else.}
}
\value{
A \code{character} vector.
}
\description{
This function returns the names of function arguments.
}
\examples{
f <- function(a, b = 1, c = "", ...) { }
function_arguments(f)
function_arguments(f, with_default = FALSE)
function_arguments(f, with_ellipsis = FALSE)

}
