#' Downloads LEGO data from Brickset.
#'
#' @param year the year of data to download.
#' @param key the Brickset key.
#' @param ... other parameters passed to \code{\link{getUserHash}} including
#'        the Brickset username and password if they are not available from
#'        \code{getOption('brickset_username')} and \code{getOption('brickset_password')}.
#' @return a data.frame with all sets from the given year.
#' @export
getSets <- function(year,
					key = getOption('brickset_key'),
					...) {
	userHash <- getUserHash(key = key, ...)

	sets <- httr::GET(paste0(brickset_api_endpoint, 'getSets?apiKey=', key,
							'&userHash=', userHash,
							'&params={year:', year, ',pageSize:1000}'))
	if(http_error(sets)) {
		stop(paste0('Error getting sets: ', http_status(sets)$message))
	}

	sets_json <- jsonlite::fromJSON(content(sets, as = 'text', encoding = "UTF-8"))
	df <- sets_json[[3]]
	if(ncol(df$LEGOCom$US)) {
		names(df$LEGOCom$US) <- paste0('US_', names(df$LEGOCom$US))
	}
	if(ncol(df$LEGOCom$UK) > 0) {
		names(df$LEGOCom$UK) <- paste0('UK_', names(df$LEGOCom$UK))
	}
	if(ncol(df$LEGOCom$CA) > 0) {
		names(df$LEGOCom$CA) <- paste0('CA_', names(df$LEGOCom$CA))
	}
	if(ncol(df$LEGOCom$DE) > 0) {
		names(df$LEGOCom$DE) <- paste0('DE_', names(df$LEGOCom$DE))
	}
	cols <- c('setID', 'name', 'year', 'theme', 'themeGroup', 'subtheme', 'category',
			  'released', 'pieces', 'minifigs', 'bricksetURL', 'rating', 'reviewCount',
			  'packagingType', 'availability', 'agerange_min',
			  names(df$LEGOCom$US), names(df$LEGOCom$UK),
			  names(df$LEGOCom$CA), names(df$LEGOCom$DE),
			  names(df$dimensions), names(df$image))
	df2 <- df %>%
		mutate(agerange_min = df$ageRange$min) %>%
		bind_cols(df$LEGOCom$US) %>%
		bind_cols(df$LEGOCom$UK) %>%
		bind_cols(df$LEGOCom$CA) %>%
		bind_cols(df$LEGOCom$DE) %>%
		bind_cols(df$dimensions) %>%
		bind_cols(df$image) %>%
		select(any_of(cols))

	if(sets_json[['matches']] != nrow(df)) {
		warning("Not all sets retrieved!") #TODO: Should loop back to get more
	}

	return(df2)
}
