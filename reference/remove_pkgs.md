# Remove packages from the project

Removes one or more packages from the manifest and updates the lockfile.
Equivalent to `uvr remove` on the command line.

## Usage

``` r
remove_pkgs(packages, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- packages:

  Character vector of package names (e.g.
  `c("ggplot2", "tidymodels@>=1.0.0", "user/repo@main")`).

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
[`import()`](import.md), [`lock()`](lock.md), [`sync()`](sync.md),
[`update_pkgs()`](update_pkgs.md)

## Examples

``` r
if (FALSE) { # \dontrun{
remove_pkgs("ggplot2")
remove_pkgs(c("dplyr", "tidyr"))
} # }
```
