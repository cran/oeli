% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R, R/tnorm.R
\name{dtnorm_cpp}
\alias{dtnorm_cpp}
\alias{dttnorm_cpp}
\alias{rtnorm_cpp}
\alias{rttnorm_cpp}
\alias{dtnorm}
\alias{dttnorm}
\alias{rtnorm}
\alias{rttnorm}
\title{Truncated normal distribution}
\usage{
dtnorm_cpp(x, mean, sd, point, above, log = FALSE)

dttnorm_cpp(x, mean, sd, lower, upper, log = FALSE)

rtnorm_cpp(mean, sd, point, above, log = FALSE)

rttnorm_cpp(mean, sd, lower, upper, log = FALSE)

dtnorm(x, mean, sd, point, above, log = FALSE)

dttnorm(x, mean, sd, lower, upper, log = FALSE)

rtnorm(mean, sd, point, above, log = FALSE)

rttnorm(mean, sd, lower, upper, log = FALSE)
}
\arguments{
\item{x}{[\code{numeric(1)}]\cr
A quantile.}

\item{mean}{[\code{numeric(1)}]\cr
The mean.}

\item{sd}{[\code{numeric(1)}]\cr
The non-negative standard deviation.}

\item{point, lower, upper}{[\code{numeric(1)}]\cr
The truncation point.}

\item{above}{[\code{logical(1)}]\cr
Truncate from above? Else, from below.}

\item{log}{[\code{logical(1)}]\cr
Return the logarithm of the density value?}
}
\value{
For \code{dtnorm()} and \code{dttnorm()}: The density value.

For \code{rtnorm()} and \code{rttnorm()}: The random draw
}
\description{
The function \code{dtnorm()} computes the density of a truncated normal
distribution.

The function \code{rtnorm()} samples from a truncated normal distribution.

The function \code{dttnorm()} and \code{rttnorm()} compute the density and sample from
a two-sided truncated normal distribution, respectively.

The functions with suffix \verb{_cpp} perform no input checks, hence are faster.
}
\examples{
x <- c(0, 0)
mean <- c(0, 0)
Sigma <- diag(2)

# compute density
dmvnorm(x = x, mean = mean, Sigma = Sigma)
dmvnorm(x = x, mean = mean, Sigma = Sigma, log = TRUE)

# sample
rmvnorm(n = 3, mean = mean, Sigma = Sigma)
rmvnorm(mean = mean, Sigma = Sigma, log = TRUE)
}
\seealso{
Other simulation helpers: 
\code{\link{Simulator}},
\code{\link{correlated_regressors}()},
\code{\link{ddirichlet_cpp}()},
\code{\link{dmvnorm_cpp}()},
\code{\link{dwishart_cpp}()},
\code{\link{simulate_markov_chain}()}
}
\concept{simulation helpers}
\keyword{distribution}
