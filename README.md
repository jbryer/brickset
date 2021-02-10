brickset
================

<a href='https://github.com/jbryer/brickset'><img src='brickset.png' align="right" height="200" /></a>

# An R package to interface with the Brickset.com API for getting data about LEGO sets

**Author:** Jason Bryer, Ph.D. <jason.bryer@cuny.edu>  
**Website:** <https://github.com/jbryer/brickset>

This package provides functions to access data about
[LEGO](https://lego.com) sets from the [Brickset](https://brickset.com)
website. The package also contains a `data.frame` with all LEGO sets (n
= 16355) from 1970 through 2020. This data set was created using the
`getSets` function and it is recommended that you use this data frame to
reduce the number of API calls. See the [build.R](build.R) script for
how the data frame was created. Documentation on the variables is
included below.

To use the Brickset API, you must first create a [Brickset
account](https://brickset.com/signup) and request an [API
key](http://brickset.com/tools/webservices/requestkey). The full
Brickset API documentation available here:
<https://brickset.com/article/52664/api-version-3-documentation>

The package can be installed from Github:

``` r
remotes::install_github('jbryer/brickset')
```

To get started, set these three R variables to your username, password,
and API key:

``` r
username <- "YOUR_USERNAME"
password <- "YOUR_PASSWORD"
key <- "YOUR_API_KEY"
```

To check if your API key is valid, call the `checkKey` function:

``` r
brickset::checkKey(key)
```

    ## [1] TRUE

Most of the Brickset API requests require you to be logged in. The
`username` and `password` can be passed to each function, or `userHash`
parameter can be reused for each session to reduce the number of calls
the the `login` function. The `checkUserHash` will verify that the login
and hash are valid.

``` r
userHash <- brickset::login(username, password, key)
brickset::checkUserHash(key, userHash)
```

    ## [1] TRUE

You can check your API usage with the `getKeyUsageStats` function.

``` r
brickset::getKeyUsageStats(key)
```

    ##              dateStamp count
    ## 1 2021-02-10T00:00:00Z     4
    ## 2 2021-02-09T00:00:00Z    60
    ## 3 2021-02-08T00:00:00Z    77

The `getSets` function returns all LEGO sets from the given year.

``` r
sets2021 <- brickset::getSets(2021, key = key, userHash = userHash)
head(sets2021, n = 3)
```

    ##   setID           name year          theme   themeGroup             subtheme
    ## 1 31026 Police Station 2021 Creator Expert Model making    Modular Buildings
    ## 2 31025 Flower Bouquet 2021 Creator Expert Model making Botanical Collection
    ## 3 30970    Bonsai Tree 2021 Creator Expert Model making Botanical Collection
    ##   category released pieces minifigs                       bricksetURL rating
    ## 1   Normal     TRUE   2923        5 https://brickset.com/sets/10278-1    4.4
    ## 2   Normal     TRUE    756       NA https://brickset.com/sets/10280-1    4.5
    ## 3   Normal     TRUE    878       NA https://brickset.com/sets/10281-1    4.5
    ##   reviewCount packagingType   availability agerange_min US_retailPrice
    ## 1           2           Box LEGO exclusive           18         199.99
    ## 2           1           Box         Retail           18          49.99
    ## 3           0           Box         Retail           18          49.99
    ##   US_dateFirstAvailable US_dateLastAvailable UK_retailPrice
    ## 1  2021-01-02T00:00:00Z 2021-01-15T00:00:00Z         169.99
    ## 2  2021-01-02T00:00:00Z 2021-01-15T00:00:00Z          44.99
    ## 3  2021-01-02T00:00:00Z 2021-01-15T00:00:00Z          44.99
    ##   UK_dateFirstAvailable UK_dateLastAvailable CA_retailPrice
    ## 1  2021-01-01T00:00:00Z                 <NA>         269.99
    ## 2  2021-01-01T00:00:00Z 2021-01-11T00:00:00Z          69.99
    ## 3  2021-01-01T00:00:00Z 2021-01-11T00:00:00Z          69.99
    ##   CA_dateFirstAvailable CA_dateLastAvailable DE_retailPrice
    ## 1  2021-01-02T00:00:00Z 2021-01-15T00:00:00Z         179.99
    ## 2  2021-01-02T00:00:00Z 2021-01-15T00:00:00Z          49.99
    ## 3  2021-01-02T00:00:00Z 2021-01-15T00:00:00Z          49.99
    ##   DE_dateFirstAvailable DE_dateLastAvailable height width depth weight
    ## 1  2021-01-02T00:00:00Z                 <NA>   47.6  57.7  11.8  4.012
    ## 2  2021-01-02T00:00:00Z 2021-01-12T00:00:00Z     NA    NA    NA     NA
    ## 3  2021-01-02T00:00:00Z 2021-01-12T00:00:00Z     NA    NA    NA     NA
    ##                                         thumbnailURL
    ## 1 https://images.brickset.com/sets/small/10278-1.jpg
    ## 2 https://images.brickset.com/sets/small/10280-1.jpg
    ## 3 https://images.brickset.com/sets/small/10281-1.jpg
    ##                                              imageURL
    ## 1 https://images.brickset.com/sets/images/10278-1.jpg
    ## 2 https://images.brickset.com/sets/images/10280-1.jpg
    ## 3 https://images.brickset.com/sets/images/10281-1.jpg

The `getReviews` function will return all reviews for a given set.

``` r
reviews29830 <- brickset::getReviews(29830, key = key, userHash = userHash)
names(reviews29830)
```

    ## [1] "author"     "datePosted" "rating"     "title"      "review"    
    ## [6] "HTML"

The `getThemes` and `getSubthemes` returns information about LEGO
themes.

``` r
themes <- getThemes(key = key, userHash = userHash)
head(themes)
```

    ##             theme setCount subthemeCount yearFrom yearTo
    ## 1       4 Juniors       24             5     2003   2004
    ## 2 Action Wheelers        9             0     2000   2001
    ## 3     Adventurers       72             4     1998   2003
    ## 4          Agents       13             0     2008   2009
    ## 5      Alpha Team       32             3     2001   2005
    ## 6    Aqua Raiders        7             0     2007   2007

``` r
subthemes <- getSubthemes('Town', key = key, userHash = userHash)
head(subthemes)
```

    ##   theme         subtheme setCount yearFrom yearTo
    ## 1  Town           {None}        3     1978   1978
    ## 2  Town      Accessories       37     1978   2002
    ## 3  Town           Arctic       10     2000   2000
    ## 4  Town            Boats       11     1990   1997
    ## 5  Town Bonus/Value Pack       13     1983   2000
    ## 6  Town             City       37     1997   2000

``` r
years <- getYears('Town', key = key, userHash = userHash)
head(years)
```

    ##   theme year setCount
    ## 1  Town 1978       34
    ## 2  Town 1979       19
    ## 3  Town 1980       17
    ## 4  Town 1981       15
    ## 5  Town 1982       10
    ## 6  Town 1983       13

## `legosets` Data Frame

``` r
data("legosets", package = "brickset")
ggplot(legosets, aes(x = year)) + geom_bar() +
    ggtitle('Number of LEGO sets by year') +
    xlab('Year') + ylab('Number of LEGO Sets')
```

![](README_files/figure-gfm/legosets_by_year-1.png)<!-- -->

The variables in the `legosets` data frame are:

|                        | Type      | Unique\_Values |
|:-----------------------|:----------|---------------:|
| setID                  | integer   |          16355 |
| name                   | character |          13523 |
| year                   | integer   |             51 |
| theme                  | character |            148 |
| themeGroup             | character |             15 |
| subtheme               | character |            766 |
| category               | character |              7 |
| released               | logical   |              2 |
| pieces                 | integer   |           1273 |
| minifigs               | integer   |             33 |
| bricksetURL            | character |          16355 |
| rating                 | numeric   |             29 |
| reviewCount            | integer   |             63 |
| packagingType          | character |             17 |
| availability           | character |             10 |
| agerange\_min          | integer   |             16 |
| US\_retailPrice        | numeric   |            365 |
| US\_dateFirstAvailable | Date      |            720 |
| US\_dateLastAvailable  | Date      |           1812 |
| UK\_retailPrice        | numeric   |            305 |
| UK\_dateFirstAvailable | Date      |            680 |
| UK\_dateLastAvailable  | Date      |           1693 |
| CA\_retailPrice        | numeric   |            142 |
| CA\_dateFirstAvailable | Date      |            489 |
| CA\_dateLastAvailable  | Date      |           1494 |
| DE\_retailPrice        | numeric   |            136 |
| DE\_dateFirstAvailable | Date      |            309 |
| DE\_dateLastAvailable  | Date      |            945 |
| height                 | numeric   |            190 |
| width                  | numeric   |            220 |
| depth                  | numeric   |            218 |
| weight                 | numeric   |            892 |
| thumbnailURL           | character |          15334 |
| imageURL               | character |          15334 |

## TODO

-   Implement the following API functions:
    -   getInstructions and getInstructions2
    -   getYears
-   Write more documentation
-   Create a pkgdown site
-   Write vignette
-   shiny app?
