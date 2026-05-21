# Remove all cached package downloads

Removes all installed packages and downloaded tarballs from the cache.
Equivalent to `uvr cache clean` on the command line.

## Usage

``` r
cache_clean(cache_dir = NULL, bin = NULL, quiet = FALSE)
```

## Arguments

- cache_dir:

  Path to cache directory. Defaults to \`NULL\`, which uses the
  \`UVR_CACHE_DIR\` environment variable if set, or \`"~/.uvr/cache/"\`
  otherwise.

- bin:

  Optional path to the uvr binary. If `NULL`, searches common locations
  using [`find_uvr`](find_uvr.md).

- quiet:

  If `TRUE`, suppress output.

## Value

A character vector of output lines (returned invisibly). On failure,
throws an error with the exit code.

## See also

Other package managers: [`add()`](add.md), [`export()`](export.md),
[`import()`](import.md), [`lock()`](lock.md),
[`remove_pkgs()`](remove_pkgs.md), [`sync()`](sync.md),
[`update_pkgs()`](update_pkgs.md)

## Examples

``` r
if (FALSE) { # \dontrun{
cache_clean()
# custom cache location - ensure used in other functions,
#   otherwise set env. var UVR_CACHE_DIR
cache_clean(cache_dir = "/tmp/uvr-cache/")
} # }
```
