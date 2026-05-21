# List R versions

Shows installed R versions. Use `all = TRUE` to show all available
versions from CRAN. Equivalent to `uvr r list` on the command line.

## Usage

``` r
r_list(all = FALSE, bin = NULL, quiet = FALSE)
```

## Arguments

- all:

  If `TRUE`, show all available versions (not just installed).

- bin:

  Optional path to the uvr binary. If `NULL`, searches common locations
  using [`find_uvr`](find_uvr.md).

- quiet:

  If `TRUE`, suppress output.

## Value

A character vector of output lines (returned invisibly). On failure,
throws an error with the exit code.

## See also

Other R version managers: [`r_install()`](r_install.md),
[`r_pin()`](r_pin.md), [`r_use()`](r_use.md)

## Examples

``` r
if (FALSE) { # \dontrun{
r_list() # installed versions
r_list(all = TRUE) # available versions
} # }
```
