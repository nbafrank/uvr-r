# Set the R version constraint

Sets the R version constraint in `uvr.toml`. Equivalent to
`uvr r use <version>` on the command line.

## Usage

``` r
r_use(version, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- version:

  Version constraint, e.g. `">=4.3.0"` or `"4.4.2"`.

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

Other R version managers: [`r_install()`](r_install.md),
[`r_list()`](r_list.md), [`r_pin()`](r_pin.md)

## Examples

``` r
if (FALSE) { # \dontrun{
r_use(">=4.3.0")
r_use("4.4.2")
} # }
```
