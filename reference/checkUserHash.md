# Check the Brickset API key.

You can request an API key on the Brickset website here:
https://brickset.com/tools/webservices/requestkey/

## Usage

``` r
checkUserHash(key = getOption("brickset_key"), userHash)
```

## Arguments

- key:

  the API key

- userHash:

  the user hash returned from
  [login](https://jbryer.github.io/brickset/reference/login.md).

## Value

TRUE if the API key is fine.

## Details

Brickset API documentation is available here:
https://brickset.com/article/52664/api-version-3-documentation/
