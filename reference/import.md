# Import renv lockfile to create uvr.toml

Converts `renv.lock` to `uvr.toml`. Equivalent to `uvr import` on the
command line.

## Usage

``` r
import(do_lock = FALSE, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- do_lock:

  If `TRUE`, create `uvr.lock` as well.

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
[`lock()`](lock.md), [`remove_pkgs()`](remove_pkgs.md),
[`sync()`](sync.md), [`update_pkgs()`](update_pkgs.md)

## Examples

``` r
if (FALSE) { # \dontrun{
import()
import(do_lock = TRUE)  # create uvr.lock as well
} # }
```
