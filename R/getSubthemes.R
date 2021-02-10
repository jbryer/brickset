#' Returns a table of sub-themes for a given theme with number of sets and years active.
#'
#' @param theme the theme
#' @param username the Brickset username.
#' @param password the Brickset password.
#' @param userHash the hash used for a logged in user. See \link{login}.
#' @return a data.frame with the subthemes.
#' @export
getSubthemes <- function(theme, key, username, password,
					  userHash = login(username, password, key)) {
	checkUserHash(key, userHash, error = TRUE)

	themes <- httr::GET(paste0(brickset_api_endpoint, 'getSubthemes?apiKey=', key,
							'&userHash=', userHash,
							'&Theme=', theme))
	if(http_error(themes)) {
		stop(paste0('Error getting subthemes: ', http_status(themes)$message))
	}

	themes_json <- jsonlite::fromJSON(content(themes, as = 'text', encoding = "UTF-8"))
	return(themes_json[[3]])
}
