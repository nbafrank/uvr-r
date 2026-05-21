# Run a uvr CLI command

Internal helper that invokes uvr with the given arguments and streams
output to the R console. Ensures that the uvr binary is found and
up-to-date.

## Usage

``` r
run_uvr(args, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- args:

  Character vector of CLI arguments.

- bin:

  Optional path to the uvr binary. If `NULL`, searches common locations
  using [`find_uvr`](find_uvr.md).

- dir:

  Optional working directory. Defaults to
  [`getwd()`](https://rdrr.io/r/base/getwd.html).

- quiet:

  If `TRUE`, suppress output.

## Value

A character vector of output lines (returned invisibly). On failure,
throws an error with the exit code.
