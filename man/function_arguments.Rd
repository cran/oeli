% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/function_arguments.R
\name{function_arguments}
\alias{function_arguments}
\title{Get function arguments}
\usage{
function_arguments(f, with_default = TRUE, with_ellipsis = TRUE)
}
\arguments{
\item{f}{[\code{function}]\cr
A \code{function}.}

\item{with_default}{[\code{logical(1)}]\cr
Include function arguments that have default values?}

\item{with_ellipsis}{[\code{logical(1)}]\cr
Include the \code{"..."} argument if present?}
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
\seealso{
Other function helpers: 
\code{\link{do.call_timed}()},
\code{\link{function_body}()},
\code{\link{function_defaults}()},
\code{\link{quiet}()},
\code{\link{timed}()},
\code{\link{try_silent}()},
\code{\link{variable_name}()}
}
\concept{function helpers}
\keyword{functional}
