#' Returns the user hash from Brickset.
#'
#' Many of the Brickset API calls require a user to login. This function wraps
#' the \code{\link{login}} function to managing the user hash returned from
#' login across multiple API calls. It will also ensure that the hash is still
#' valid and if it expired a new hash will be requested.
#'
#' Brickset API documentation is available here:
#' https://brickset.com/article/52664/api-version-3-documentation/
#'
#' @param username the Brickset username.
#' @param password the Brickset password.
#' @param key the Brickset API key.
#' @return the user hash for the current API session.
#' @export
getUserHash <- function(username = getOption('brickset_username'),
						password = getOption('brickset_password'),
						key = getOption('brickset_key')) {
	if(is.null(username) | is.null(password) | is.null(key)) {
		stop('Brickset username, password, and/or key not specified.')
	}
	userHash <- getOption('brickset_user_hash', default = NULL)
	if(is.null(userHash) | !checkUserHash(key, userHash)) {
		userHash <- login(username, password, key)
		options(brickset_user_hash = userHash)
	}
	return(userHash)
}
