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
getKeyUsageStats <- function(key, error = TRUE) {
	usageStats <- httr::GET(paste0(brickset_api_endpoint, 'getKeyUsageStats?apiKey=', key))
	if(error & http_error(usageStats)) {
		stop(paste0('Error getting usage stats: ', http_status(usageStats)$message))
	}
	df <- jsonlite::fromJSON(content(usageStats, as = 'text', encoding = "UTF-8"))$apiKeyUsage
	return(df)
}
