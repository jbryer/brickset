# Check the Brickset API key.

You can request an API key on the Brickset website here:
https://brickset.com/tools/webservices/requestkey/

## Usage

``` r
checkKey(key = getOption("brickset_key"))
```

## Arguments

- key:

  the Brickset API key

## Value

TRUE if the API key is valid.

## Details

The API key can be passed as function parameter or may be set globally
using:

`options(brickset_key = YOUR_API_KEY)`

Brickset API documentation is available here:
https://brickset.com/article/52664/api-version-3-documentation

## Examples

``` r
if (FALSE) { # \dontrun{
options(brickset_key = 'BRICKSET_KEY',
        brickset_username = 'BRICKSET_UERNAME',
        brickset_password = 'BRICKSET_PASSWORD')
checkKey() # Will return TRUE if the credentials are correct
} # }
```
