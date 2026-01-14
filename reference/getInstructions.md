# Download list of instructions for given set.

Brickset API documentation is available here:
https://brickset.com/article/52664/api-version-3-documentation/

## Usage

``` r
getInstructions(setID, setNumber, key = getOption("brickset_key"), ...)
```

## Arguments

- setID:

  the ID of the set (see `data(legosets)`)

- setNumber:

  the set number from on the LEGO box

- key:

  the Brickset API key.

- ...:

  other parameters passed to
  [`getUserHash`](https://jbryer.github.io/brickset/reference/getUserHash.md)
  including the Brickset username and password if they are not available
  from `getOption('brickset_username')` and
  `getOption('brickset_password')`.

## Value

a data.frame with the instructions.
