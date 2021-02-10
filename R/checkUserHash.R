#' Check the Brickset API key.
#'
#' You can request an API key on the Brickset website here:
#' http://brickset.com/tools/webservices/requestkey
#'
#' @param key the API key
#' @param userHash the user hash returned from \link{login}.
#' @param error if TRUE, the function will throw an error. If FALSE, then the
#'        function will return TRUE if the key check failed.
#' @return TRUE if the API key is fine.
#' @export
checkUserHash <- function(key, userHash, error = TRUE) {
	if(!checkKey(key, error = error)) {
		return(FALSE)
	}
	checkUserHash <- httr::GET(paste0(brickset_api_endpoint,
								 'checkUserHash?apiKey=', key,
								 '&userHash=', userHash))
	if(error & http_error(checkUserHash)) {
		stop(paste0('Error checking user hash: ', http_status(checkUserHash)$message))
	}
	user_hash_json <- jsonlite::fromJSON(content(checkUserHash, as = 'text', encoding = "UTF-8"))
	return(user_hash_json$status == 'success')
}
