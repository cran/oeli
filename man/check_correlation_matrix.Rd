% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_correlation_matrix.R
\name{check_correlation_matrix}
\alias{check_correlation_matrix}
\alias{assert_correlation_matrix}
\alias{test_correlation_matrix}
\title{Check correlation matrix}
\usage{
check_correlation_matrix(x, dim = NULL, tolerance = sqrt(.Machine$double.eps))

assert_correlation_matrix(
  x,
  dim = NULL,
  tolerance = sqrt(.Machine$double.eps),
  .var.name = checkmate::vname(x),
  add = NULL
)

test_correlation_matrix(x, dim = NULL, tolerance = sqrt(.Machine$double.eps))
}
\arguments{
\item{x}{[any]\cr
Object to check.}

\item{dim}{[\code{integer(1)}]\cr
The matrix dimension.}

\item{tolerance}{[\code{numeric(1)}]\cr
A non-negative tolerance value.}

\item{.var.name}{[\code{character(1)}]\cr
Name of the checked object to print in assertions. Defaults to
the heuristic implemented in \code{\link[checkmate]{vname}}.}

\item{add}{[\code{AssertCollection}]\cr
Collection to store assertion messages. See \code{\link[checkmate]{AssertCollection}}.}
}
\value{
Same as documented in \code{\link[checkmate]{check_matrix}}.
}
\description{
These functions check whether the input fulfills the properties of a
correlation matrix.
}
\examples{
M <- matrix(c(1,  0.9,  0.9, 0.9,  1,  -0.9, 0.9,  -0.9,  1), nrow = 3)
check_correlation_matrix(M)
test_correlation_matrix(M)
\dontrun{
assert_correlation_matrix(M)
}
}
\seealso{
Other matrix helpers: 
\code{\link{check_covariance_matrix}()},
\code{\link{check_transition_probability_matrix}()},
\code{\link{cov_to_chol}()},
\code{\link{diff_cov}()},
\code{\link{insert_matrix_column}()},
\code{\link{matrix_diagonal_indices}()},
\code{\link{matrix_indices}()},
\code{\link{sample_correlation_matrix}()},
\code{\link{sample_covariance_matrix}()},
\code{\link{sample_transition_probability_matrix}()},
\code{\link{stationary_distribution}()}
}
\concept{matrix helpers}
\keyword{validation}
