% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getReviews.R
\name{getReviews}
\alias{getReviews}
\title{Downloads reviews for a LEGO set.}
\usage{
getReviews(setID, key = getOption("brickset_key"), ...)
}
\arguments{
\item{key}{the Brickset API key.}

\item{...}{other parameters passed to \code{\link{getUserHash}} including
the Brickset username and password if they are not available from
\code{getOption('brickset_username')} and \code{getOption('brickset_password')}.}

\item{setId}{the ID of the set (see \code{data(legosets)})}
}
\value{
a data.frame with the reviews.
}
\description{
Downloads reviews for a LEGO set.
}
