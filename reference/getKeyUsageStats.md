# Get information about frequency of API usage for the given API key.

Provides information about how frequently the API key has been used.

## Usage

``` r
getKeyUsageStats(key = getOption("brickset_key"))
```

## Arguments

- key:

  the API key

## Value

a data.frame with the number of times the key has been used.

- dateStamp:

  The date

- count:

  The number of times the key was used for the given date

## Examples

``` r
if (FALSE) { # \dontrun{
options(brickset_key = 'BRICKSET_KEY',
        brickset_username = 'BRICKSET_UERNAME',
        brickset_password = 'BRICKSET_PASSWORD')
getKeyUsageStats()
} # }
```
