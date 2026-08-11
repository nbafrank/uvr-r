# Remove cached package downloads

With no filters, removes all installed packages and downloaded tarballs
from the cache. With filters, removes only the entries that match every
given filter (requires uvr \>= 0.4.2). Equivalent to
`uvr cache clean [--package <name>] [--r-version <minor>]` on the
command line.

## Usage

``` r
cache_clean(
  package = NULL,
  r_version = NULL,
  cache_dir = NULL,
  bin = NULL,
  quiet = FALSE
)
```

## Arguments

- package:

  Optional character vector of package names: remove only cache entries
  for these packages.

- r_version:

  Optional character vector of R minor versions (e.g. `"4.4"`): remove
  only cache entries built for these R series. Full versions like
  `"4.4.2"` are treated as their minor series.

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
[`remove_pkgs()`](remove_pkgs.md), [`scan()`](scan.md),
[`sync()`](sync.md), [`tree()`](tree.md),
[`update_pkgs()`](update_pkgs.md)

## Examples

``` r
if (FALSE) { # \dontrun{
cache_clean() # remove everything
cache_clean(package = "sf") # one package's entries only
cache_clean(r_version = "4.4") # one R series only
cache_clean(package = c("sf", "terra"), r_version = "4.5")
# custom cache location - ensure used in other functions,
#   otherwise set env. var UVR_CACHE_DIR
cache_clean(cache_dir = "/tmp/uvr-cache/")
} # }
```
