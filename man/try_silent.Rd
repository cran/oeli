% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/try_silent.R
\name{try_silent}
\alias{try_silent}
\title{Try an expression silently}
\usage{
try_silent(expr)
}
\arguments{
\item{expr}{[\code{expression}]\cr
An R expression to be evaluated.}
}
\value{
Either the value of \code{expr} or in case of a failure an object of class
\code{fail}, which contains the error message.
}
\description{
This function tries to execute \code{expr} and returns a string with the
error message if the execution failed.
}
\details{
This function is a wrapper for \code{\link[base]{try}}.
}
\examples{
\dontrun{
try_silent(1 + 1)
try_silent(1 + "1")
}
}
\seealso{
Other function helpers: 
\code{\link{do.call_timed}()},
\code{\link{function_arguments}()},
\code{\link{function_body}()},
\code{\link{function_defaults}()},
\code{\link{quiet}()},
\code{\link{timed}()},
\code{\link{variable_name}()}
}
\concept{function helpers}
\keyword{functional}
