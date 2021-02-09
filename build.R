

# Build the package
devtools::document()
devtools::install()
devtools::build()

library(brickset)
ls('package:brickset')
data("legosets", package = 'brickset')

names(legosets)
dim(legosets)

source('brickset_login.R') # Need to define username, password, and key

ggplot(legosets, aes(x = year)) + geom_bar() +
	ggtitle('Number of LEGO sets by year') +
	xlab('Year') + ylab('Number of LEGO Sets')

################################################################################
# Test the functions

brickset::checkKey(key)
userHash <- brickset::login(username, password, key)
brickset::checkUserHash(key, userHash)
brickset::getKeyUsageStats(key)

sets2021 <- brickset::getSets(2021, key = key, userHash = userHash)

reviews29830 <- brickset::getReviews(29830, key = key, userHash = userHash)


################################################################################
# Build the datasets
# Download data files.
pb <- txtProgressBar(min = 1970, max = lubridate::year(Sys.Date()) - 1, initial = 1970, style = 3)
for(i in seq(1970, lubridate::year(Sys.Date()) - 1)) {
	sets <- brickset::getSets(i, key = key, userHash = userHash)
	write.csv(sets, paste0('data-raw/', i, '.csv'), row.names = FALSE)
	setTxtProgressBar(pb, value = i)
}
close(pb)
# Merge the CSV files into one data.frame
csv_files <- rev(list.files('data-raw/', pattern = '*.csv'))
legosets <- data.frame()
for(i in csv_files) {
	newfile <- read.csv(paste0('data-raw/', i))
	missing_cols <- names(legosets)[!names(legosets) %in% names(newfile)]
	for(j in missing_cols) {
		newfile[,j] <- NA
	}
	if(ncol(legosets) > 0) {
		legosets <- rbind(newfile[,names(legosets)], legosets)
	} else {
		legosets <- newfile
	}
}
legosets <- legosets %>%
	mutate(US_dateFirstAvailable = as.Date(US_dateFirstAvailable),
		   US_dateLastAvailable = as.Date(US_dateLastAvailable),
		   UK_dateFirstAvailable = as.Date(UK_dateFirstAvailable),
		   UK_dateLastAvailable = as.Date(UK_dateLastAvailable),
		   CA_dateFirstAvailable = as.Date(CA_dateFirstAvailable),
		   CA_dateLastAvailable = as.Date(CA_dateLastAvailable),
		   DE_dateFirstAvailable = as.Date(DE_dateFirstAvailable),
		   DE_dateLastAvailable = as.Date(DE_dateLastAvailable))
save(legosets, file = 'data/legosets.rda')
# NOTE: Need to reinstall the package after the legosets.rda file is saved
