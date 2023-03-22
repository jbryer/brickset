#' Returns a table of themes with number of sets and years active.
#'
#' Brickset API documentation is available here:
#' https://brickset.com/article/52664/api-version-3-documentation/
#'
#' @param key the Brickset API key.
#' @param ... other parameters passed to \code{\link{getUserHash}} including
#'        the Brickset username and password if they are not available from
#'        \code{getOption('brickset_username')} and \code{getOption('brickset_password')}.
#' @return a data.frame with the themes.
#' @export
#' @examples
#' \dontrun{
#' options(brickset_key = 'BRICKSET_KEY',
#'         brickset_username = 'BRICKSET_UERNAME',
#'         brickset_password = 'BRICKSET_PASSWORD')
#' getThemes()
#' }
getThemes <- function(key = getOption('brickset_key'),
					  ...) {
	userHash <- getUserHash(key = key, ...)

	themes <- httr::GET(paste0(brickset_api_endpoint, 'getThemes?apiKey=', key,
							'&userHash=', userHash))
	if(httr::http_error(themes)) {
		stop(paste0('Error getting themes: ', httr::http_status(themes)$message))
	}

	themes_json <- jsonlite::fromJSON(httr::content(themes, as = 'text', encoding = "UTF-8"))
	return(themes_json[[3]])
}
