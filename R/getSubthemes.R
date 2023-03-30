#' Returns a table of sub-themes for a given theme with number of sets and years active.
#'
#' Brickset API documentation is available here:
#' https://brickset.com/article/52664/api-version-3-documentation/
#'
#' @param theme the theme.
#' @param key the Brickset API key.
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
	if(httr::http_error(themes)) {
		stop(paste0('Error getting subthemes: ', httr::http_status(themes)$message))
	}

	themes_json <- jsonlite::fromJSON(httr::content(themes, as = 'text', encoding = "UTF-8"))

	if(themes_json$status == 'error') {
		stop(paste0('Error getting sets: ', themes_json$message))
	}

	return(themes_json[[3]])
}
