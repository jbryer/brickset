# Build the package
usethis::use_tidy_description()
devtools::document()
devtools::install()
devtools::install(build_vignettes = TRUE)
devtools::build()
devtools::build_readme()

devtools::check(cran = TRUE)
devtools::check_win_release()
devtools::check_rhub()

devtools::release()


library(brickset)
ls('package:brickset')
data("legosets", package = 'brickset')
?legosets

vignette(package = 'brickset')
vignette('lego_more_expensive')
vignette('predicting_set_price')

library(ggplot2)
names(legosets)
dim(legosets)

ggplot(legosets, aes(x = year)) + geom_bar() +
	ggtitle('Number of LEGO sets by year') +
	xlab('Year') + ylab('Number of LEGO Sets')

################################################################################
# Test the API functions

source('brickset_config.R') # Need to define username, password, and key

brickset::checkKey()
( userHash <- brickset::getUserHash() )
brickset::getKeyUsageStats()

brickset::getThemes() |> head()
brickset::getSubthemes('Toy Story')
brickset::getYears('Toy Story')
sets2021 <- brickset::getSets(2021)
reviews29830 <- brickset::getReviews(29830)

reviews <- brickset::download_reviews()

################################################################################
# Merge the CSV files into one data.frame
merge_csv_files <- function(dir) {
	csv_files <- rev(list.files(dir, pattern = '*.csv'))
	df <- data.frame()
	for(i in csv_files) {
		newfile <- read.csv(paste0(dir, i))
		missing_cols <- names(df)[!names(df) %in% names(newfile)]
		for(j in missing_cols) {
			newfile[,j] <- NA
		}
		if(ncol(df) > 0) {
			df <- rbind(newfile[,names(df)], df)
		} else {
			df <- newfile
		}
	}
	return(df)
}

################################################################################
# Build the datasets
# Download data files.
sets_path <- 'data-raw/sets/'
pb <- txtProgressBar(min = 1970, max = lubridate::year(Sys.Date()) - 1, initial = 1970, style = 3)
for(i in seq(1970, lubridate::year(Sys.Date()) - 1)) {
	sets <- brickset::getSets(i)
	write.csv(sets, paste0(sets_path, i, '.csv'), row.names = FALSE)
	setTxtProgressBar(pb, value = i)
}
close(pb)

legosets <- merge_csv_files(sets_path) |>
	dplyr::mutate(US_dateFirstAvailable = as.Date(US_dateFirstAvailable),
				  US_dateLastAvailable = as.Date(US_dateLastAvailable),
				  UK_dateFirstAvailable = as.Date(UK_dateFirstAvailable),
				  UK_dateLastAvailable = as.Date(UK_dateLastAvailable),
				  CA_dateFirstAvailable = as.Date(CA_dateFirstAvailable),
				  CA_dateLastAvailable = as.Date(CA_dateLastAvailable),
				  DE_dateFirstAvailable = as.Date(DE_dateFirstAvailable),
				  DE_dateLastAvailable = as.Date(DE_dateLastAvailable))
save(legosets, file = 'data/legosets.rda')
tools::resaveRdaFiles('data/legosets.rda')

################################################################################
# Rebrickable Downloads https://rebrickable.com/downloads/
rebrickable_urls <- c(
	'https://cdn.rebrickable.com/media/downloads/themes.csv.gz',
	'https://cdn.rebrickable.com/media/downloads/colors.csv.gz',
	'https://cdn.rebrickable.com/media/downloads/part_categories.csv.gz',
	'https://cdn.rebrickable.com/media/downloads/parts.csv.gz',
	'https://cdn.rebrickable.com/media/downloads/part_relationships.csv.gz',
	'https://cdn.rebrickable.com/media/downloads/elements.csv.gz',
	'https://cdn.rebrickable.com/media/downloads/sets.csv.gz',
	'https://cdn.rebrickable.com/media/downloads/minifigs.csv.gz',
	'https://cdn.rebrickable.com/media/downloads/inventories.csv.gz',
	'https://cdn.rebrickable.com/media/downloads/inventory_parts.csv.gz',
	'https://cdn.rebrickable.com/media/downloads/inventory_sets.csv.gz',
	'https://cdn.rebrickable.com/media/downloads/inventory_minifigs.csv.gz'
)

rebrickable_path <- 'data-raw/rebrickable/'
dir.create(rebrickable_path, showWarnings = FALSE, recursive = TRUE)
for(i in rebrickable_urls) {
	zip_file <- paste0(rebrickable_path, '/', basename(i))
	if(file.exists(zip_file)) {
		unlink(zip_file)
	}
	download.file(i, zip_file)
	R.utils::gunzip(zip_file, overwrite = TRUE)
}

df <- read.csv('data-raw/rebrickable/colors.csv')
usethis::use_data(df)

################################################################################
# Build the reviews dataset
library(brickset)
library(ggplot2)

data(legosets, package = 'brickset')

reviews_path <- 'data-raw/reviews/'

review_sets <- legosets[legosets$reviewCount > 0,]
review_sets <- review_sets[order(review_sets$reviewCount, decreasing = TRUE),]
nrow(review_sets)

pb <- txtProgressBar(min = 0, max = nrow(review_sets), initial = 0, style = 3)
rows <- 1:nrow(review_sets)
# rows <- 1:2
for(i in rows) {
	setTxtProgressBar(pb, value = i)
	csv_file <- paste0(reviews_path, review_sets[i,]$setID, '.csv')
	if(file.exists(csv_file)) {
		reviews <- read.csv(csv_file)
		if(nrow(reviews) >= review_sets[i,]$reviewCount) {
			next
		}
	}
	tryCatch({
		reviews <- brickset::getReviews(review_sets[i,]$setID)
		if(nrow(reviews) > 0) {
			write.csv(reviews, csv_file, row.names = FALSE)
		}
	}, error = function(e) {
		warning(paste0('Could not get reviews for set ID ', review_sets[i,]$setID))
	})
}
close(pb)

reviews <- merge_csv_files(dir = reviews_path)

# The reviews data frame is too large to include in the R package. Will
# upload to Github using piggyback package
save(reviews, file = 'data-raw/reviews.rda')
tools::resaveRdaFiles('data-raw/reviews.rda')

piggyback::pb_upload(file = 'data-raw/reviews.rda',
					 repo = 'jbryer/brickset',
					 tag = paste0('reviews', gsub('-', '.', as.character(Sys.Date()))))

piggyback::pb_list(repo = 'jbryer/brickset')

tmp_dir <- tempdir()
reviews_file <- paste0(tmp_dir, '/reviews.rda')
piggyback::pb_download('reviews.rda',
					   repo = 'jbryer/brickset',
					   dest = tmp_dir)
if(file.exists(reviews_file)) {
	load(reviews_file)
}

# table(legosets[legosets$reviewCount > 0,]$reviewCount)
# nrow(legosets[legosets$reviewCount > 1,])
# ggplot(legosets, aes(x = reviewCount)) + geom_histogram(binwidth = 1)
