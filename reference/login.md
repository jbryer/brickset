# Login to the Brickset API.

Brickset API documentation is available here:
https://brickset.com/article/52664/api-version-3-documentation/

## Usage

``` r
login(
  username = getOption("brickset_username"),
  password = getOption("brickset_password"),
  key = getOption("brickset_key")
)
```

## Arguments

- username:

  the Brickset username.

- password:

  the Brickset password.

- key:

  the Brickset API key.

## Value

the user hash used for other API calls.
