% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/occurrence_info.R
\name{occurrence_info}
\alias{occurrence_info}
\title{Provide information about occurrences}
\usage{
occurrence_info(x, relative = FALSE, named = FALSE)
}
\arguments{
\item{x}{[\code{data.frame}]\cr
The object to check for occurrences.}

\item{relative}{[\code{logical(1)} ]\cr
The number of rows or columns to be printed, greater or equal \code{2}.}

\item{named}{[\code{logical(1)} ]\cr
Prepend column names of \code{x} (if not \code{NA})?}
}
\value{
A \code{character()}.
}
\description{
This function provides verbose information about absolute or relative
element occurrences in \code{data.frame} columns.
}
\examples{
occurrence_info(datasets::warpbreaks, relative = FALSE, named = TRUE)
}
\seealso{
Other data.frame helpers: 
\code{\link{delete_columns_data.frame}()},
\code{\link{group_data.frame}()},
\code{\link{round_data.frame}()}
}
\concept{data.frame helpers}
\keyword{packaging}
