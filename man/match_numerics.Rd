% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/index_helpers.R
\name{match_numerics}
\alias{match_numerics}
\title{Best-possible match of two numeric vectors}
\usage{
match_numerics(x, y)
}
\arguments{
\item{x}{A \code{numeric} vector.}

\item{y}{Another \code{numeric} vector of the same length as \code{x}.}
}
\value{
An \code{integer} vector of length \code{length(x)} with the positions of
\code{y} in \code{x}.
}
\description{
This function matches the indices of two numeric vectors as good as possible
(that means with the smallest possible sum of deviations).
}
\examples{
x <- c(-1, 0, 1)
y <- c(0.1, 1.5, -1.2)
match_numerics(x, y)

}
