# Export lockfile to renv.lock format

Converts `uvr.lock` to `renv.lock`. Equivalent to `uvr export` on the
command line.

## Usage

``` r
export(out_file = NULL, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- out_file:

  Name of the output lockfile. Defaults to `NULL`, returning the output
  via the console instead of writing to a file.

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
[`cache_clean()`](cache_clean.md), [`import()`](import.md),
[`lock()`](lock.md), [`remove_pkgs()`](remove_pkgs.md),
[`scan()`](scan.md), [`sync()`](sync.md), [`tree()`](tree.md),
[`update_pkgs()`](update_pkgs.md)

## Examples

``` r
if (FALSE) { # \dontrun{
lock_lines <- export() # store as variable
export(out_file = "renv.lock") # export to file
} # }
```
