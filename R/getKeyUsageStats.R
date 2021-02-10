#' Check the Brickset API key.
#'
#' You can request an API key on the Brickset website here:
#' http://brickset.com/tools/webservices/requestkey
#'
#' @param key the API key
#' @return TRUE if the API key is fine.
#' @export
getKeyUsageStats <- function(key = getOption('brickset_key')) {
	usageStats <- httr::GET(paste0(brickset_api_endpoint, 'getKeyUsageStats?apiKey=', key))
	if(http_error(usageStats)) {
		stop(paste0('Error getting usage stats: ', http_status(usageStats)$message))
	}
	df <- jsonlite::fromJSON(content(usageStats, as = 'text', encoding = "UTF-8"))$apiKeyUsage
	return(df)
}
