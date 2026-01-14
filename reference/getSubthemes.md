# Returns a table of sub-themes for a given theme with number of sets and years active.

Brickset API documentation is available here:
https://brickset.com/article/52664/api-version-3-documentation/

## Usage

``` r
getSubthemes(theme, key = getOption("brickset_key"), ...)
```

## Arguments

- theme:

  the theme.

- key:

  the Brickset API key.

- ...:

  other parameters passed to
  [`getUserHash`](https://jbryer.github.io/brickset/reference/getUserHash.md)
  including the Brickset username and password if they are not available
  from `getOption('brickset_username')` and
  `getOption('brickset_password')`.

## Value

a data.frame with the subthemes.
