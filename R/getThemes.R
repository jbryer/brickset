#' Returns a table of themes with number of sets and years active.
#'
#' @param key the Brickset API key.
#' @param ... other parameters passed to \code{\link{getUserHash}} including
#'        the Brickset username and password if they are not available from
#'        \code{getOption('brickset_username')} and \code{getOption('brickset_password')}.
#' @return a data.frame with the themes.
#' @export
getThemes <- function(key = getOption('brickset_key'),
					  ...) {
	userHash <- getUserHash(key = key, ...)

	themes <- httr::GET(paste0(brickset_api_endpoint, 'getThemes?apiKey=', key,
							'&userHash=', userHash))
	if(http_error(themes)) {
		stop(paste0('Error getting themes: ', http_status(themes)$message))
	}

	themes_json <- jsonlite::fromJSON(content(themes, as = 'text', encoding = "UTF-8"))
	return(themes_json[[3]])
}
