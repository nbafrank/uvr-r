# Diagnose environment issues (R, build tools, project status)

Equivalent to `uvr doctor` on the command line.

## Usage

``` r
doctor(bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

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

## See also

Other uvr setup functions: [`completions()`](completions.md),
[`init()`](init.md), [`install_uvr()`](install_uvr.md),
[`update_uvr()`](update_uvr.md)

## Examples

``` r
if (FALSE) { # \dontrun{
doctor()
} # }
```
