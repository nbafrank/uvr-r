# Synchronize project library from lockfile

Installs all packages specified in `uvr.lock`. Idempotent — skips
packages that are already installed. Equivalent to `uvr sync`.

## Usage

``` r
sync(frozen = FALSE, bin = NULL, dir = NULL, cache_dir = NULL, quiet = FALSE)
```

## Arguments

- frozen:

  If `TRUE`, fail if the lockfile is out of date (CI mode).

- bin:

  Optional path to the uvr binary. If `NULL`, searches common locations
  using [`find_uvr`](find_uvr.md).

- dir:

  Optional working directory. Defaults to
  [`getwd()`](https://rdrr.io/r/base/getwd.html).

- cache_dir:

  Path to cache directory. Defaults to \`NULL\`, which uses the
  \`UVR_CACHE_DIR\` environment variable if set, or \`"~/.uvr/cache/"\`
  otherwise.

- quiet:

  If `TRUE`, suppress output.

## Value

A character vector of output lines (returned invisibly). On failure,
throws an error with the exit code.

## See also

Other package managers: [`add()`](add.md),
[`cache_clean()`](cache_clean.md), [`export()`](export.md),
[`import()`](import.md), [`lock()`](lock.md),
[`remove_pkgs()`](remove_pkgs.md), [`update_pkgs()`](update_pkgs.md)

## Examples

``` r
if (FALSE) { # \dontrun{
sync()
sync(frozen = TRUE)  # CI mode: fail if lockfile is stale
} # }
```
