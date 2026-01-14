# Downloads a pre-built reviews data frame.

This function will return a data frame with all the reviews as of last
package build. Since this data frame is larger than what is allowed in
CRAN packages, the data files are saved as releases on Github. The
[`piggyback::pb_upload()`](https://docs.ropensci.org/piggyback/reference/pb_upload.html)
function is used to upload the data frame.

## Usage

``` r
download_reviews(dest = tempdir(), ...)
```

## Arguments

- dest:

  directory to download the `reviews.rda` file to.

- ...:

  other parameters passed to
  [`piggyback::pb_download()`](https://docs.ropensci.org/piggyback/reference/pb_download.html).

## Value

a data frame with all the reviews as of the tag date.

## Details

To see what versions are available use the
`piggyback::pb_list(repo = 'jbryer/brickset')` function call. By default
the latest version will be returned. For reproducibility you can use the
`tag` parameter to return a specific version of the data frame.
