#' Download list of instructions for given set.
#'
#' @param setId the ID of the set (see \code{data(legosets)})
#' @param setNumber the set number from on the LEGO box
#' @param key the Brickset key.
#' @param username the Brickset username.
#' @param password the Brickset password.
#' @param userHash the hash used for a logged in user. See \link{login}.
#' @return a data.frame with the reviews.
#' @export
getInstructions <- function(setID, setNumber, key, username, password,
					        userHash = login(username, password, key)) {
	checkUserHash(key, userHash, error = TRUE)

	url <- NULL
	if(!missing(setID)) {
		url <- paste0(brickset_api_endpoint, 'getInstructions?apiKey=', key,
					  '&userHash=', userHash,
					  '&setID=', setID)
	} else if(!missing(setNumber)) {
		url <- paste0(brickset_api_endpoint, 'getInstructions2?apiKey=', key,
					  '&userHash=', userHash,
					  '&setNumber=', setNumber)
	} else {
		stop("Either setID or setNumber must be specified.")
	}
	instructions <- httr::GET(url)
	if(http_error(instructions)) {
		stop(paste0('Error getting instructions: ', http_status(instructions)$message))
	}

	instructions_json <- jsonlite::fromJSON(content(instructions, as = 'text', encoding = "UTF-8"))
	return(instructions_json[[3]])
}
