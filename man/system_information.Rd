% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/package_helpers.R
\name{system_information}
\alias{system_information}
\title{General system level information}
\usage{
system_information()
}
\value{
A \code{list} with elements:
\itemize{
\item \code{maschine}, the model name of the device
\item \code{cores}, the number of cores
\item \code{RAM}, the size of the RAM
\item \code{OS}, the operating system
\item \code{r_version}, the R version used
}
}
\description{
This function returns a \code{list} of general system level information.
}
