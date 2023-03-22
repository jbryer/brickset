#' Get information about frequency of API usage for the given API key.
#'
#' Provides information about how frequently the API key has been used.
#'
#' @param key the API key
#' @return a data.frame with the number of times the key has been used.
#' \describe{
#' \item{dateStamp}{The date}
#' \item{count}{The number of times the key was used for the given date}
#' }
#' @export
#' @examples
#' \dontrun{
#' options(brickset_key = 'BRICKSET_KEY',
#'         brickset_username = 'BRICKSET_UERNAME',
#'         brickset_password = 'BRICKSET_PASSWORD')
#' getKeyUsageStats()
#' }
getKeyUsageStats <- function(key = getOption('brickset_key')) {
	usageStats <- httr::GET(paste0(brickset_api_endpoint, 'getKeyUsageStats?apiKey=', key))
	if(httr::http_error(usageStats)) {
		stop(paste0('Error getting usage stats: ', httr::http_status(usageStats)$message))
	}
	df <- jsonlite::fromJSON(httr::content(usageStats, as = 'text', encoding = "UTF-8"))$apiKeyUsage
	return(df)
}
