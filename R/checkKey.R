#' Check the Brickset API key.
#'
#' You can request an API key on the Brickset website here:
#' http://brickset.com/tools/webservices/requestkey
#'
#' The API key can be passed as function parameter or may be set globally using:
#'
#' \code{options(brickset_key = YOUR_API_KEY)}
#'
#' @param key the Brickset API key
#' @return TRUE if the API key is valid.
#' @export
checkKey <- function(key = getOption('brickset_key')) {
	checkKey <- httr::GET(paste0(brickset_api_endpoint, 'checkKey?apiKey=', key))
	if(http_error(checkKey)) {
		message(paste0('Error checking API key: ', http_status(checkKey)$message))
		return(FALSE)
	}
	key_json <- jsonlite::fromJSON(content(checkKey, as = 'text', encoding = "UTF-8"))
	return(key_json$status == 'success')
}
