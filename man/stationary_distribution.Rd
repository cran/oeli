% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/markov_chain.R
\name{stationary_distribution}
\alias{stationary_distribution}
\title{Stationary distribution}
\usage{
stationary_distribution(tpm, soft_fail = FALSE)
}
\arguments{
\item{tpm}{A transition probability \code{matrix}.}

\item{soft_fail}{Either \code{TRUE} to return the discrete uniform distribution if the
computation of the stationary distribution fails for some reason, or
\code{FALSE} to throw an error.}
}
\value{
A \code{numeric} vector.
}
\description{
This function computes the stationary distribution corresponding to a
transition probability matrix.
}
\examples{
tpm <- matrix(0.05, nrow = 3, ncol = 3)
diag(tpm) <- 0.9
stationary_distribution(tpm)

}
