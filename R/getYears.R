#' Get a list of years for a given theme, with the total number of sets in each.
#'
#' @param theme the theme
#' @param key the Brickset API key.
#' @param ... other parameters passed to \code{\link{getUserHash}} including
#'        the Brickset username and password if they are not available from
#'        \code{getOption('brickset_username')} and \code{getOption('brickset_password')}.
#' @return a data.frame with the years of a given theme.
#' \describe{
#' \item{theme}{Name of the theme}
#' \item{year}{Year}
#' \item{setCount}{Number of sets released in the given year and theme}
#' }
#' @export
#' @examples
#' \dontrun{
#' options(brickset_key = 'BRICKSET_KEY',
#'         brickset_username = 'BRICKSET_UERNAME',
#'         brickset_password = 'BRICKSET_PASSWORD')
#' getYears('Architecture')
#' }
getYears <- function(theme,
					 key = getOption('brickset_key'),
					 ...) {
	userHash <- getUserHash(key = key, ...)

	years <- httr::GET(paste0(brickset_api_endpoint, 'getYears?apiKey=', key,
							'&userHash=', userHash,
							'&Theme=', utils::URLencode(theme)))
	if(httr::http_error(years)) {
		stop(paste0('Error getting years: ', httr::http_status(years)$message))
	}

	years_json <- jsonlite::fromJSON(httr::content(years, as = 'text', encoding = "UTF-8"))

	if(years_json$status == 'error') {
		stop(paste0('Error getting sets: ', years_json$message))
	}

	return(years_json[[3]])
}
