#' Downloads Lego data.
#'
#' @param setId the ID of the set (see \code{data(legosets)})
#' @param key the Brickset key.
#' @param username the Brickset username.
#' @param password the Brickset password.
#' @param userHash the hash used for a logged in user. See \link{login}.
#' @return a data.frame with the reviews.
#' @export
getReviews <- function(setID, key, username, password,
					userHash = login(username, password, key)) {
	checkUserHash(key, userHash, error = TRUE)

	reviews <- httr::GET(paste0(brickset_api_endpoint, 'getReviews?apiKey=', key,
							'&userHash=', userHash,
							'&setID=', setID))
	if(http_error(reviews)) {
		stop(paste0('Error getting reviews: ', http_status(reviews)$message))
	}

	reviews_json <- jsonlite::fromJSON(content(reviews, as = 'text', encoding = "UTF-8"))
	return(reviews_json[[3]])
}
