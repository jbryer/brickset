# Get a list of years for a given theme, with the total number of sets in each.

Get a list of years for a given theme, with the total number of sets in
each.

## Usage

``` r
getYears(theme, key = getOption("brickset_key"), ...)
```

## Arguments

- theme:

  the theme

- key:

  the Brickset API key.

- ...:

  other parameters passed to
  [`getUserHash`](https://jbryer.github.io/brickset/reference/getUserHash.md)
  including the Brickset username and password if they are not available
  from `getOption('brickset_username')` and
  `getOption('brickset_password')`.

## Value

a data.frame with the years of a given theme.

- theme:

  Name of the theme

- year:

  Year

- setCount:

  Number of sets released in the given year and theme

## Examples

``` r
if (FALSE) { # \dontrun{
options(brickset_key = 'BRICKSET_KEY',
        brickset_username = 'BRICKSET_UERNAME',
        brickset_password = 'BRICKSET_PASSWORD')
getYears('Architecture')
} # }
```
