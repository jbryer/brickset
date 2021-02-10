#' Check the Brickset API key.
#'
#' You can request an API key on the Brickset website here:
#' http://brickset.com/tools/webservices/requestkey
#'
#' @param key the API key
#' @param error if TRUE, the function will throw an error. If FALSE, then the
#'        function will return TRUE if the key check failed.
#' @return TRUE if the API key is fine.
#' @export
checkKey <- function(key, error = TRUE) {
	checkKey <- httr::GET(paste0(brickset_api_endpoint, 'checkKey?apiKey=', key))
	if(error & http_error(checkKey)) {
		stop(paste0('Error checking API key: ', http_status(checkKey)$message))
	}
	key_json <- jsonlite::fromJSON(content(checkKey, as = 'text', encoding = "UTF-8"))
	return(key_json$status == 'success')
}
