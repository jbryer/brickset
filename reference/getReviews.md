# Downloads reviews for a LEGO set.

Downloads reviews for a LEGO set.

## Usage

``` r
getReviews(setID, key = getOption("brickset_key"), ...)
```

## Arguments

- setID:

  the ID of the set (see `data(legosets)`)

- key:

  the Brickset API key.

- ...:

  other parameters passed to
  [`getUserHash`](https://jbryer.github.io/brickset/reference/getUserHash.md)
  including the Brickset username and password if they are not available
  from `getOption('brickset_username')` and
  `getOption('brickset_password')`.

## Value

a data.frame with the reviews.

- author:

  Author of the review

- datePosted:

  Date of the review

- title:

  Title of the review

- review:

  The text of the review

- HTML:

  TRUE if the review contains HTML

- overall:

  overall rating by the reviewer

- parts:

  rating for the parts

- buildingExperience:

  rating for the building experience

- playability:

  rating for the playability

- valueForMoney:

  rating for the value for money

## Examples

``` r
if (FALSE) { # \dontrun{
options(brickset_key = 'BRICKSET_KEY',
        brickset_username = 'BRICKSET_UERNAME',
        brickset_password = 'BRICKSET_PASSWORD')
getReviews('31728') # Will return TRUE if the credentials are correct
} # }
```
