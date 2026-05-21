# Install an R version

Downloads and installs a specific R version to `~/.uvr/r-versions/`.
Equivalent to `uvr r install <version>` on the command line.

## Usage

``` r
r_install(version, bin = NULL, quiet = FALSE)
```

## Arguments

- version:

  R version string, e.g. `"4.4.2"`.

- bin:

  Optional path to the uvr binary. If `NULL`, searches common locations
  using [`find_uvr`](find_uvr.md).

- quiet:

  If `TRUE`, suppress output.

## Value

A character vector of output lines (returned invisibly). On failure,
throws an error with the exit code.

## See also

Other R version managers: [`r_list()`](r_list.md),
[`r_pin()`](r_pin.md), [`r_use()`](r_use.md)

## Examples

``` r
if (FALSE) { # \dontrun{
r_install("4.4.2")
} # }
```
