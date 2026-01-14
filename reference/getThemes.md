# Returns a table of themes with number of sets and years active.

Brickset API documentation is available here:
https://brickset.com/article/52664/api-version-3-documentation/

## Usage

``` r
getThemes(key = getOption("brickset_key"), ...)
```

## Arguments

- key:

  the Brickset API key.

- ...:

  other parameters passed to
  [`getUserHash`](https://jbryer.github.io/brickset/reference/getUserHash.md)
  including the Brickset username and password if they are not available
  from `getOption('brickset_username')` and
  `getOption('brickset_password')`.

## Value

a data.frame with the themes.

## Examples

``` r
if (FALSE) { # \dontrun{
options(brickset_key = 'BRICKSET_KEY',
        brickset_username = 'BRICKSET_UERNAME',
        brickset_password = 'BRICKSET_PASSWORD')
getThemes()
} # }
```
