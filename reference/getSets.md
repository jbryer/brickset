# Downloads LEGO data from Brickset.

Brickset API documentation is available here:
https://brickset.com/article/52664/api-version-3-documentation/

## Usage

``` r
getSets(year, key = getOption("brickset_key"), ...)
```

## Arguments

- year:

  the year of data to download.

- key:

  the Brickset key.

- ...:

  other parameters passed to
  [`getUserHash`](https://jbryer.github.io/brickset/reference/getUserHash.md)
  including the Brickset username and password if they are not available
  from `getOption('brickset_username')` and
  `getOption('brickset_password')`.

## Value

a data.frame with all sets from the given year.

- setID:

  integer; 21546 unique values

- number:

  character; 20037 unique values

- numberVariant:

  integer; 25 unique values

- name:

  character; 18081 unique values

- year:

  integer; 56 unique values

- theme:

  character; 171 unique values

- themeGroup:

  character; 17 unique values

- subtheme:

  character; 1055 unique values

- category:

  character; 7 unique values

- released:

  logical; 2 unique values

- pieces:

  integer; 1621 unique values

- minifigs:

  integer; 35 unique values

- bricksetURL:

  character; 21546 unique values

- rating:

  numeric; 29 unique values

- reviewCount:

  integer; 64 unique values

- packagingType:

  character; 19 unique values

- availability:

  character; 12 unique values

- agerange_min:

  integer; 19 unique values

- thumbnailURL:

  character; 20514 unique values

- imageURL:

  character; 20514 unique values

- US_retailPrice:

  numeric; 194 unique values

- US_dateFirstAvailable:

  Date; 1213 unique values

- US_dateLastAvailable:

  Date; 2487 unique values

- UK_retailPrice:

  numeric; 228 unique values

- UK_dateFirstAvailable:

  Date; 1132 unique values

- UK_dateLastAvailable:

  Date; 2393 unique values

- CA_retailPrice:

  numeric; 204 unique values

- CA_dateFirstAvailable:

  Date; 962 unique values

- CA_dateLastAvailable:

  Date; 2165 unique values

- DE_retailPrice:

  numeric; 183 unique values

- DE_dateFirstAvailable:

  Date; 724 unique values

- DE_dateLastAvailable:

  Date; 1590 unique values

- height:

  numeric; 292 unique values

- width:

  numeric; 349 unique values

- depth:

  numeric; 318 unique values

- weight:

  numeric; 1296 unique values
