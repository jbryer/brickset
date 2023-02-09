#' Returns a table of sub-themes for a given theme with number of sets and years active.
#'
#' @param theme the theme
#' @param ... other parameters passed to \code{\link{getUserHash}} including
#'        the Brickset username and password if they are not available from
#'        \code{getOption('brickset_username')} and \code{getOption('brickset_password')}.
#' @return a data.frame with the subthemes.
#' @export
getSubthemes <- function(theme,
						 key = getOption('brickset_key'),
						 ...) {
	userHash <- getUserHash(key = key, ...)

	themes <- httr::GET(paste0(brickset_api_endpoint, 'getSubthemes?apiKey=', key,
							'&userHash=', userHash,
							'&Theme=', utils::URLencode(theme)))
	if(http_error(themes)) {
		stop(paste0('Error getting subthemes: ', http_status(themes)$message))
	}

	themes_json <- jsonlite::fromJSON(content(themes, as = 'text', encoding = "UTF-8"))
	return(themes_json[[3]])
}
