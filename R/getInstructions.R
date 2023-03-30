#' Download list of instructions for given set.
#'
#' Brickset API documentation is available here:
#' https://brickset.com/article/52664/api-version-3-documentation/
#'
#' @param setID the ID of the set (see \code{data(legosets)})
#' @param setNumber the set number from on the LEGO box
#' @param key the Brickset API key.
#' @param ... other parameters passed to \code{\link{getUserHash}} including
#'        the Brickset username and password if they are not available from
#'        \code{getOption('brickset_username')} and \code{getOption('brickset_password')}.
#' @return a data.frame with the instructions.
#' @export
getInstructions <- function(setID,
							setNumber,
							key = getOption('brickset_key'),
							...) {
	userHash <- getUserHash(key = key, ...)

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

	instructions_json <- jsonlite::fromJSON(httr::content(instructions, as = 'text', encoding = "UTF-8"))

	if(instructions_json$status == 'error') {
		stop(paste0('Error getting sets: ', instructions_json$message))
	}

	return(instructions_json[[3]])
}
