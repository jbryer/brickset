#' Check the Brickset API key.
#'
#' You can request an API key on the Brickset website here:
#' http://brickset.com/tools/webservices/requestkey
#'
#' @param key the API key
#' @param userHash the user hash returned from \link{login}.
#' @return TRUE if the API key is fine.
#' @export
checkUserHash <- function(key = getOption('brickset_key'),
						  userHash) {
	if(!checkKey(key)) {
		return(FALSE)
	}
	checkUserHash <- httr::GET(paste0(brickset_api_endpoint,
								 'checkUserHash?apiKey=', key,
								 '&userHash=', userHash))
	if(http_error(checkUserHash)) {
		message(paste0('Error checking user hash: ', http_status(checkUserHash)$message))
		return(FALSE)
	}
	user_hash_json <- jsonlite::fromJSON(content(checkUserHash, as = 'text', encoding = "UTF-8"))
	return(user_hash_json$status == 'success')
}
