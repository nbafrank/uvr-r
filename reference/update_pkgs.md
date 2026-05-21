# Update installed packages to the latest allowed versions

Convenience wrapper that re-resolves the lockfile with
`lock(upgrade = TRUE)` and then installs the updates with
[`sync()`](sync.md). Equivalent to running
`uvr lock --upgrade && uvr sync` on the command line.

## Usage

``` r
update_pkgs(do_sync = TRUE, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- do_sync:

  If `TRUE`, install the updated packages using [`sync()`](sync.md).

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
[`import()`](import.md), [`lock()`](lock.md),
[`remove_pkgs()`](remove_pkgs.md), [`sync()`](sync.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Update the lockfile and install updated packages
update_pkgs()

# Don't install updated packages, just update the lockfile
update_pkgs(do_sync = FALSE)
} # }
```
