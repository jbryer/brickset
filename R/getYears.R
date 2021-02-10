#' Get a list of years for a given theme, with the total number of sets in each.
#'
#' @param theme the theme
#' @param username the Brickset username.
#' @param password the Brickset password.
#' @param userHash the hash used for a logged in user. See \link{login}.
#' @return a data.frame with the years of a given theme.
#' @export
getYears <- function(theme, key, username, password,
					  userHash = login(username, password, key)) {
	checkUserHash(key, userHash, error = TRUE)

	years <- httr::GET(paste0(brickset_api_endpoint, 'getYears?apiKey=', key,
							'&userHash=', userHash,
							'&Theme=', theme))
	if(http_error(years)) {
		stop(paste0('Error getting years: ', http_status(years)$message))
	}

	years_json <- jsonlite::fromJSON(content(years, as = 'text', encoding = "UTF-8"))
	return(years_json[[3]])
}
