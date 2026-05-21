# Pin the R version

Writes an exact R version to the `.r-version` file. Equivalent to
`uvr r pin <version>` on the command line.

## Usage

``` r
r_pin(version, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- version:

  R version string, e.g. `"4.4.2"`.

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
[`r_list()`](r_list.md), [`r_use()`](r_use.md)

## Examples

``` r
if (FALSE) { # \dontrun{
r_pin("4.4.2")
} # }
```
