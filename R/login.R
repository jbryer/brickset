#' Login to the Brickset API.
#'
#' @param username the Brickset username.
#' @param password the Brickset password.
#' @param key the Brickset API key.
#' @return the user hash used for other API calls.
#' @export
login <- function(username = getOption('brickset_username'),
				  password  = getOption('brickset_password'),
				  key = getOption('brickset_key')) {
	checkKey(key)

	login <- httr::GET(paste0(brickset_api_endpoint, 'login?apiKey=', key,
							  '&username=', username,
							  '&password=', password))
	if(http_error(login)) {
		stop(paste0('Error logging in: ', http_status(login)$message))
	}

	userHash <- jsonlite::fromJSON(content(login, as = 'text', encoding = 'UTF-8'))$hash

	return(userHash)
}
