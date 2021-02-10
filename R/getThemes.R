#' Returns a table of themes with number of sets and years active.
#'
#' @param username the Brickset username.
#' @param password the Brickset password.
#' @param userHash the hash used for a logged in user. See \link{login}.
#' @return a data.frame with the themes.
#' @export
getThemes <- function(key, username, password,
					  userHash = login(username, password, key)) {
	checkUserHash(key, userHash, error = TRUE)

	themes <- httr::GET(paste0(brickset_api_endpoint, 'getThemes?apiKey=', key,
							'&userHash=', userHash))
	if(http_error(themes)) {
		stop(paste0('Error getting themes: ', http_status(themes)$message))
	}

	themes_json <- jsonlite::fromJSON(content(themes, as = 'text', encoding = "UTF-8"))
	return(themes_json[[3]])
}
