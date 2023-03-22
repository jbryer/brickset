brickset_api_endpoint <- 'https://brickset.com/api/v3.asmx/'

#' R package to interface with the Brickset API for getting data about LEGO.
#'
#' @name brickset-package
#' @docType package
#' @title R package to interface with the Brickset API for getting data about LEGO.
#' @author \email{jason@@bryer.org}
#' @keywords data lego
#' @import httr
#' @import dplyr
#' @import jsonlite
NULL

#' Lego sets from 1970 through 2022.
#'
#' This dataset was built using the \code{\link{getSets}} function. For working
#' with the LEGO sets data frame this pre-built data is preferred as it will
#' minimize the API requests. Note that the only disadvantage is that the
#' \code{rating} and \code{reviewCount} may be out-of-date and inaccurate. The
#' remaining variables are relatively static.
#'
#' @format A data.frame.
#' ```{r, child = "man/rmd/legosets.Rmd"}
#' ```
#' @name legosets
#' @docType data
#' @source \url{https://brickset.com}
#' @keywords data, lego
NULL
