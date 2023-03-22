#' Check the Brickset API key.
#'
#' You can request an API key on the Brickset website here:
#' https://brickset.com/tools/webservices/requestkey/
#'
#' The API key can be passed as function parameter or may be set globally using:
#'
#' \code{options(brickset_key = YOUR_API_KEY)}
#'
#' Brickset API documentation is available here:
#' https://brickset.com/article/52664/api-version-3-documentation
#'
#' @param key the Brickset API key
#' @return TRUE if the API key is valid.
#' @export
#' @examples
#' \dontrun{
#' options(brickset_key = 'BRICKSET_KEY',
#'         brickset_username = 'BRICKSET_UERNAME',
#'         brickset_password = 'BRICKSET_PASSWORD')
#' checkKey() # Will return TRUE if the credentials are correct
#' }
checkKey <- function(key = getOption('brickset_key')) {
	checkKey <- httr::GET(paste0(brickset_api_endpoint, 'checkKey?apiKey=', key))
	if(httr::http_error(checkKey)) {
		message(paste0('Error checking API key: ', httr::http_status(checkKey)$message))
		return(FALSE)
	}
	key_json <- jsonlite::fromJSON(httr::content(checkKey, as = 'text', encoding = "UTF-8"))
	return(key_json$status == 'success')
}
