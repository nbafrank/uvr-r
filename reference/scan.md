# Find packages your code uses but the manifest does not declare

Scans the project's `.R`, `.Rmd` and `.qmd` files for
[`library()`](https://rdrr.io/r/base/library.html),
[`require()`](https://rdrr.io/r/base/library.html) and `pkg::fun()`
usage, and reports anything missing from `uvr.toml`. Equivalent to
`uvr scan`.

## Usage

``` r
scan(all = FALSE, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- all:

  If `TRUE`, list every package found rather than only the ones missing
  from the manifest.

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

## Details

Useful straight after [`import`](import.md), or on a project that
predates uvr, to catch dependencies nobody wrote down.

## See also

Other package managers: [`add()`](add.md),
[`cache_clean()`](cache_clean.md), [`export()`](export.md),
[`import()`](import.md), [`lock()`](lock.md),
[`remove_pkgs()`](remove_pkgs.md), [`sync()`](sync.md),
[`tree()`](tree.md), [`update_pkgs()`](update_pkgs.md)

## Examples

``` r
if (FALSE) { # \dontrun{
scan()             # what's used but undeclared?
scan(all = TRUE)   # everything the scan found
} # }
```
