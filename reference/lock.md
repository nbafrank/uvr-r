# Update the lockfile

Re-resolves all dependencies and writes `uvr.lock` without installing.
Equivalent to `uvr lock`.

## Usage

``` r
lock(upgrade = FALSE, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- upgrade:

  If `TRUE`, upgrade all packages to their latest allowed versions.

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

Other package managers: [`add()`](add.md),
[`cache_clean()`](cache_clean.md), [`export()`](export.md),
[`import()`](import.md), [`remove_pkgs()`](remove_pkgs.md),
[`sync()`](sync.md), [`update_pkgs()`](update_pkgs.md)

## Examples

``` r
if (FALSE) { # \dontrun{
lock()
lock(upgrade = TRUE)  # upgrade all packages to latest versions
} # }
```
