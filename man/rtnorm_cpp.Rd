% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{rtnorm_cpp}
\alias{rtnorm_cpp}
\alias{rttnorm_cpp}
\title{Draw from univariate truncated normal}
\usage{
rtnorm_cpp(mean, sd, point, above, log = FALSE)

rttnorm_cpp(mean, sd, lower, upper, log = FALSE)
}
\arguments{
\item{mean}{A \code{numeric}, the mean.}

\item{sd}{A \code{numeric}, the standard deviation.}

\item{point}{A \code{numeric}, the truncation point.}

\item{above}{A \code{logical}, if \code{TRUE} truncation from above and if \code{FALSE}
truncation from below.}

\item{log}{A \code{logical}, if \code{TRUE} the draw is taken from the log-normal
distribution.
By default, \code{log = FALSE}.}

\item{lower}{A \code{numeric}, the lower truncation point.}

\item{upper}{A \code{numeric}, the upper truncation point.}
}
\value{
A \code{numeric}, the random draw.
}
\description{
\code{rtnorm_cpp} draws from a one-sided truncated univariate normal
distribution.
\code{rttnorm_cpp} draws from a two-sided truncated univariate normal
distribution.
}
\details{
These function performs no input checks.
}
\keyword{internal}
