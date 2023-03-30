#' Downloads reviews for a LEGO set.
#'
#' @param setID the ID of the set (see \code{data(legosets)})
#' @param key the Brickset API key.
#' @param ... other parameters passed to \code{\link{getUserHash}} including
#'        the Brickset username and password if they are not available from
#'        \code{getOption('brickset_username')} and \code{getOption('brickset_password')}.
#' @return a data.frame with the reviews.
#' \describe{
#' \item{author}{Author of the review}
#' \item{datePosted}{Date of the review}
#' \item{title}{Title of the review}
#' \item{review}{The text of the review}
#' \item{HTML}{TRUE if the review contains HTML}
#' \item{overall}{overall rating by the reviewer}
#' \item{parts}{rating for the parts}
#' \item{buildingExperience}{rating for the building experience}
#' \item{playability}{rating for the playability}
#' \item{valueForMoney}{rating for the value for money}
#' }
#' @export
#' @examples
#' \dontrun{
#' options(brickset_key = 'BRICKSET_KEY',
#'         brickset_username = 'BRICKSET_UERNAME',
#'         brickset_password = 'BRICKSET_PASSWORD')
#' getReviews('31728') # Will return TRUE if the credentials are correct
#' }
getReviews <- function(setID,
					   key = getOption('brickset_key'),
					   ...) {
	userHash <- getUserHash(key = key, ...)

	reviews <- httr::GET(paste0(brickset_api_endpoint, 'getReviews?apiKey=', key,
							'&userHash=', userHash,
							'&setID=', setID))
	if(httr::http_error(reviews)) {
		stop(paste0('Error getting reviews: ', httr::http_status(reviews)$message))
	}

	reviews_json <- jsonlite::fromJSON(httr::content(reviews, as = 'text', encoding = "UTF-8"))

	if(reviews_json$status == 'error') {
		stop(paste0('Error getting sets: ', reviews_json$message))
	}

	df <- reviews_json[[3]]
	cols <- c('author', 'datePosted', 'title', 'review', 'HTML', names(df$rating))
	df2 <- df |>
		dplyr::bind_cols(df$rating) |>
		dplyr::select(dplyr::any_of(cols))

	return(df2)
}
