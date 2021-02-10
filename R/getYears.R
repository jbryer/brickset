#' Get a list of years for a given theme, with the total number of sets in each.
#'
#' @param theme the theme
#' @param key the Brickset API key.
#' @param ... other parameters passed to \code{\link{getUserHash}} including
#'        the Brickset username and password if they are not available from
#'        \code{getOption('brickset_username')} and \code{getOption('brickset_password')}.
#' @return a data.frame with the years of a given theme.
#' @export
getYears <- function(theme,
					 key = getOption('brickset_key'),
					 ...) {
	userHash <- getUserHash(key = key, ...)

	years <- httr::GET(paste0(brickset_api_endpoint, 'getYears?apiKey=', key,
							'&userHash=', userHash,
							'&Theme=', utils::URLencode(theme)))
	if(http_error(years)) {
		stop(paste0('Error getting years: ', http_status(years)$message))
	}

	years_json <- jsonlite::fromJSON(content(years, as = 'text', encoding = "UTF-8"))
	return(years_json[[3]])
}
