brickset_api_endpoint <- 'https://brickset.com/api/v3.asmx/'

#' R package to interface with the Brickset API for getting data about LEGO.
#'
#' You can request an API key on the Brickset website here:
#' https://brickset.com/tools/webservices/requestkey/
#'
#' The API key can be passed as function parameter or may be set globally using:
#'
#' \code{options(brickset_key = YOUR_API_KEY)}
#' @name brickset
#' @docType package
#' @title R package to interface with the Brickset API for getting data about LEGO.
#' @author \email{jason@@bryer.org}
#' @keywords data lego
#' @importFrom httr GET http_error http_status content
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr bind_cols select mutate any_of
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
#' @keywords lego
NULL
