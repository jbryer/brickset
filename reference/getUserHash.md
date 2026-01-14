# Returns the user hash from Brickset.

Many of the Brickset API calls require a user to login. This function
wraps the
[`login`](https://jbryer.github.io/brickset/reference/login.md) function
to managing the user hash returned from login across multiple API calls.
It will also ensure that the hash is still valid and if it expired a new
hash will be requested.

## Usage

``` r
getUserHash(
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

the user hash for the current API session.

## Details

Brickset API documentation is available here:
https://brickset.com/article/52664/api-version-3-documentation/
