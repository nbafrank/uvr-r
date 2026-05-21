# Find the uvr binary

Searches for the `uvr` executable on the system PATH and common
installation locations. Stops with a helpful message if not found.

## Usage

``` r
find_uvr(check_path = TRUE)
```

## Arguments

- check_path:

  If `TRUE`, check the PATH first.

## Value

The path to the `uvr` binary (character string).
