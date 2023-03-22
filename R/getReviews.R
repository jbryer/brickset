#' Downloads reviews for a LEGO set.
#'
#' @param setID the ID of the set (see \code{data(legosets)})
#' @param key the Brickset API key.
#' @param ... other parameters passed to \code{\link{getUserHash}} including
#'        the Brickset username and password if they are not available from
#'        \code{getOption('brickset_username')} and \code{getOption('brickset_password')}.
#' @return a data.frame with the reviews.
#' @export
getReviews <- function(setID,
					   key = getOption('brickset_key'),
					   ...) {
	userHash <- getUserHash(key = key, ...)

	reviews <- httr::GET(paste0(brickset_api_endpoint, 'getReviews?apiKey=', key,
							'&userHash=', userHash,
							'&setID=', setID))
	if(http_error(reviews)) {
		stop(paste0('Error getting reviews: ', http_status(reviews)$message))
	}

	reviews_json <- jsonlite::fromJSON(content(reviews, as = 'text', encoding = "UTF-8"))

	df <- reviews_json[[3]]
	cols <- c('author', 'datePosted', 'title', 'review', 'HTML', names(df$rating))
	df2 <- df %>%
		bind_cols(df$rating) %>%
		select(any_of(cols))

	return(df2)
}
