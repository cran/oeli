% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sample_covariance_matrix.R
\name{sample_covariance_matrix}
\alias{sample_covariance_matrix}
\title{Sample covariance matrix}
\usage{
sample_covariance_matrix(dim, df = dim, scale = diag(dim), diag = FALSE)
}
\arguments{
\item{dim}{[\code{integer(1)}]\cr
The dimension.}

\item{df}{[\code{integer(1)}]\cr
The degrees of freedom of the inverse Wishart distribution greater or equal
\code{dim}.}

\item{scale}{[\code{matrix()}]\cr
The scale covariance matrix of the inverse Wishart distribution of dimension
\code{dim}.}

\item{diag}{[\code{logical(1)}]\cr
Diagonal matrix?}
}
\value{
A covariance \code{matrix}.
}
\description{
This function samples a covariance matrix from an inverse Wishart
distribution.
}
\examples{
sample_covariance_matrix(dim = 3)
}
\seealso{
Other matrix helpers: 
\code{\link{check_correlation_matrix}()},
\code{\link{check_covariance_matrix}()},
\code{\link{check_transition_probability_matrix}()},
\code{\link{cov_to_chol}()},
\code{\link{diff_cov}()},
\code{\link{insert_matrix_column}()},
\code{\link{matrix_diagonal_indices}()},
\code{\link{matrix_indices}()},
\code{\link{sample_correlation_matrix}()},
\code{\link{sample_transition_probability_matrix}()},
\code{\link{stationary_distribution}()}
}
\concept{matrix helpers}
\keyword{simulation}
