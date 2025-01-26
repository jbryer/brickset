
# <a href='https://github.com/jbryer/brickset'><img src='man/figures/brickset.png' align="right" width="120" /></a> brickset: An R Package to Interface with the Brickset API for Getting Data About LEGO sets

<!-- badges: start -->

[![R-CMD-check](https://github.com/jbryer/brickset/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jbryer/brickset/actions/workflows/R-CMD-check.yaml)
[![](https://img.shields.io/badge/devel%20version-2025.0.0-blue.svg)](https://github.com/jbryer/brickset)
[![](https://www.r-pkg.org/badges/version/brickset)](https://cran.r-project.org/package=brickset)
[![CRAN
Status](https://badges.cranchecks.info/flavor/release/brickset.svg)](https://cran.r-project.org/web/checks/check_results_brickset.html)
<!-- badges: end -->

**Author:** Jason Bryer, Ph.D. <jason@bryer.org>  
**Website:** <https://jbryer.github.io/brickset/>

This package provides functions to access data about
[LEGO](https://www.lego.com/) sets from the
[Brickset](https://brickset.com/) website. The package also contains a
`data.frame` with all LEGO sets (n = 20,420) from 1970 through 2024.
This data set was created using the `getSets` function and it is
recommended that you use this data frame to reduce the number of API
calls. See the
[build.R](https://github.com/jbryer/PSAboot/blob/master/build.R) script
for how the data frame was created. Information about the variables is
included below.

## Installation

You can download from CRAN using:

``` r
install.packages('brickset')
```

Or the latest development version using the `remotes` package:

``` r
remotes::install_github('jbryer/brickset')
```

## Brickset API

To use the Brickset API, you must first create a [Brickset
account](https://brickset.com/signup) and request an [API
key](https://brickset.com/tools/webservices/requestkey). The full
Brickset API documentation is available here:
<https://brickset.com/article/52664/api-version-3-documentation>

Most of the functions require a Brickset username, password, and API
key. You can pass these as parameters, or you can set these options:

``` r
options(brickset_key = 'YOUR_API_KEY',
        brickset_username = 'YOUR_USERNAME',
        brickset_password = 'YOUR_PASSWORD')
```

The `checkKey` function will verify that your API key is valid:

``` r
brickset::checkKey()
#> [1] TRUE
```

You can check your API usage with the `getKeyUsageStats` function.

``` r
brickset::getKeyUsageStats()
#>              dateStamp count
#> 1 2025-01-21T00:00:00Z    56
```

The `getSets` function returns all LEGO sets from the given year.

``` r
sets2021 <- brickset::getSets(2021)
head(sets2021, n = 3)
#>   setID number numberVariant                     name year theme   themeGroup
#> 1 31026  10278             1           Police Station 2021 Icons Model making
#> 2 31754  10279             1 Volkswagen T2 Camper Van 2021 Icons Model making
#> 3 31025  10280             1           Flower Bouquet 2021 Icons Model making
#>                       subtheme category released pieces minifigs
#> 1 Modular Buildings Collection   Normal     TRUE   2923        5
#> 2                     Vehicles   Normal     TRUE   2207       NA
#> 3         Botanical Collection   Normal     TRUE    756       NA
#>                         bricksetURL rating reviewCount packagingType
#> 1 https://brickset.com/sets/10278-1    4.3           4           Box
#> 2 https://brickset.com/sets/10279-1    4.0           0           Box
#> 3 https://brickset.com/sets/10280-1    4.1           3           Box
#>     availability agerange_min
#> 1 LEGO exclusive           18
#> 2 LEGO exclusive           18
#> 3         Retail           18
#>                                         thumbnailURL
#> 1 https://images.brickset.com/sets/small/10278-1.jpg
#> 2 https://images.brickset.com/sets/small/10279-1.jpg
#> 3 https://images.brickset.com/sets/small/10280-1.jpg
#>                                              imageURL US_retailPrice
#> 1 https://images.brickset.com/sets/images/10278-1.jpg         199.99
#> 2 https://images.brickset.com/sets/images/10279-1.jpg         179.99
#> 3 https://images.brickset.com/sets/images/10280-1.jpg          59.99
#>   US_dateFirstAvailable US_dateLastAvailable UK_retailPrice
#> 1  2021-01-02T00:00:00Z 2024-02-05T00:00:00Z         169.99
#> 2  2021-08-02T00:00:00Z 2022-11-12T00:00:00Z         139.99
#> 3  2021-01-02T00:00:00Z                 <NA>          54.99
#>   UK_dateFirstAvailable UK_dateLastAvailable CA_retailPrice
#> 1  2021-01-01T00:00:00Z 2024-01-12T00:00:00Z         269.99
#> 2  2021-08-01T00:00:00Z 2022-11-29T00:00:00Z         249.99
#> 3  2021-01-01T00:00:00Z                 <NA>          79.99
#>   CA_dateFirstAvailable CA_dateLastAvailable DE_retailPrice
#> 1  2021-01-02T00:00:00Z 2024-02-05T00:00:00Z         199.99
#> 2  2021-08-03T00:00:00Z 2022-11-12T00:00:00Z         159.99
#> 3  2021-01-02T00:00:00Z                 <NA>          59.99
#>   DE_dateFirstAvailable DE_dateLastAvailable height width depth weight
#> 1  2021-01-02T00:00:00Z 2024-02-19T00:00:00Z   47.6  57.7  11.8  4.012
#> 2  2021-08-02T00:00:00Z 2022-11-30T00:00:00Z   37.4  57.8  11.2  2.945
#> 3  2021-01-02T00:00:00Z                 <NA>   38.2  26.2   7.1  0.760
```

The `getReviews` function will return all reviews for a given set.

``` r
reviews29830 <- brickset::getReviews(29830)
names(reviews29830)
#>  [1] "author"             "datePosted"         "title"             
#>  [4] "review"             "HTML"               "overall"           
#>  [7] "parts"              "buildingExperience" "playability"       
#> [10] "valueForMoney"
```

The `getThemes` and `getSubthemes` returns information about LEGO
themes.

``` r
getThemes() |> head(n = 3)
#>             theme setCount subthemeCount yearFrom yearTo
#> 1       4 Juniors       24             5     2003   2004
#> 2 Action Wheelers        9             0     2000   2001
#> 3 Advanced models       35            12     2000   2012
getSubthemes('Toy Story')
#>       theme          subtheme setCount yearFrom yearTo
#> 1 Toy Story Buildable Figures        2     2010   2010
#> 2 Toy Story     Original Film        2     2010   2010
#> 3 Toy Story       Toy Story 2        3     2010   2010
#> 4 Toy Story       Toy Story 3        8     2010   2010
getYears('Toy Story')
#>       theme year setCount
#> 1 Toy Story 2010       15
```

The `getInstructions` will return a table with the URLs to the building
instructions.

``` r
instructions <- getInstructions(setID = 29830)
instructions
#>                                                                       URL
#> 1 https://www.lego.com/cdn/product-assets/product.bi.core.pdf/6313846.pdf
#> 2 https://www.lego.com/cdn/product-assets/product.bi.core.pdf/6313848.pdf
#> 3 https://www.lego.com/cdn/product-assets/product.bi.core.pdf/6313849.pdf
#> 4 https://www.lego.com/cdn/product-assets/product.bi.core.pdf/6313850.pdf
#>                             description
#> 1 BI 3103, 112+4/65+200G, 10270 V29 1/2
#> 2   BI 3103, 96+4/65+200G,10270 V29 2/2
#> 3   BI 3103, 112+4/65+200G, V39/142 1/2
#> 4    BI 3103, 96+4/65+200G, V39/142 2/2
```

## `legosets` Dataset

The `legosets` data frame contains all LEGO sets (n = 20,420) from 1970
through 2024.

``` r
data("legosets", package = "brickset")
ggplot(legosets, aes(x = year)) + geom_bar() +
    ggtitle('Number of LEGO sets by year') +
    xlab('Year') + ylab('Number of LEGO Sets')
```

<img src="man/figures/README-legosets_by_year-1.png" width="100%" />

``` r
ggplot(legosets, aes(x = pieces, y = US_retailPrice)) + 
    geom_point() +
    ggtitle('Cost of LEGO sets by number of pieces') +
    xlab('Number of LEGO pieces') + ylab('US Retail Price (dollars)')
```

<img src="man/figures/README-pieces_by_price-1.png" width="100%" />

The variables in the `legosets` data frame are:

|                       | Type      | Unique_Values |
|:----------------------|:----------|--------------:|
| setID                 | integer   |         20420 |
| number                | character |         18958 |
| numberVariant         | integer   |            25 |
| name                  | character |         17057 |
| year                  | integer   |            55 |
| theme                 | character |           163 |
| themeGroup            | character |            17 |
| subtheme              | character |          1000 |
| category              | character |             7 |
| released              | logical   |             2 |
| pieces                | integer   |          1543 |
| minifigs              | integer   |            34 |
| bricksetURL           | character |         20420 |
| rating                | numeric   |            29 |
| reviewCount           | integer   |            64 |
| packagingType         | character |            19 |
| availability          | character |            11 |
| agerange_min          | integer   |            18 |
| thumbnailURL          | character |         19365 |
| imageURL              | character |         19365 |
| US_retailPrice        | numeric   |           173 |
| US_dateFirstAvailable | Date      |          1090 |
| US_dateLastAvailable  | Date      |          2324 |
| UK_retailPrice        | numeric   |           224 |
| UK_dateFirstAvailable | Date      |          1019 |
| UK_dateLastAvailable  | Date      |          2224 |
| CA_retailPrice        | numeric   |           188 |
| CA_dateFirstAvailable | Date      |           851 |
| CA_dateLastAvailable  | Date      |          2005 |
| DE_retailPrice        | numeric   |           179 |
| DE_dateFirstAvailable | Date      |           607 |
| DE_dateLastAvailable  | Date      |          1402 |
| height                | numeric   |           264 |
| width                 | numeric   |           317 |
| depth                 | numeric   |           307 |
| weight                | numeric   |          1192 |

## Code of Conduct

Please note that the brickset project is released with a [Contributor
Code of
Conduct](https://jbryer.github.io/brickset/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
