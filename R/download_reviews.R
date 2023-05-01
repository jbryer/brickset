#' Downloads a pre-built reviews data frame.
#'
#' This function will return a data frame with all the reviews as of last package
#' build. Since this data frame is larger than what is allowed in CRAN packages,
#' the data files are saved as releases on Github. The [piggyback::pb_upload()]
#' function is used to upload the data frame.
#'
#' To see what versions are available use the `piggyback::pb_list(repo = 'jbryer/brickset')`
#' function call. By default the latest version will be returned. For reproducibility
#' you can use the `tag` parameter to return a specific version of the data frame.
#'
#' @param dest directory to download the `reviews.rda` file to.
#' @param ... other parameters passed to [piggyback::pb_download()].
#' @return a data frame with all the reviews as of the tag date.
#' @export
#' @importFrom piggyback pb_download
download_reviews <- function(dest = tempdir(), ...) {
	reviews_file <- paste0(dest, '/reviews.rda')
	piggyback::pb_download('reviews.rda',
						   repo = 'jbryer/brickset',
						   dest = dest,
						   ...)
	if(file.exists(reviews_file)) {
		new_env <- environment()
		load(reviews_file, envir = new_env)
		return(get('reviews', new_env))
	} else {
		return(NULL)
	}
}
