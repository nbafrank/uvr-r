# Add packages to the project

Adds one or more packages to the manifest, updates the lockfile, and
installs them. Equivalent to `uvr add` on the command line.

## Usage

``` r
add(
  packages,
  dev = FALSE,
  bioc = FALSE,
  do_lock = TRUE,
  do_install = TRUE,
  bin = NULL,
  dir = NULL,
  cache_dir = NULL,
  quiet = FALSE
)
```

## Arguments

- packages:

  Character vector of package names (e.g.
  `c("ggplot2", "tidymodels@>=1.0.0", "user/repo@main")`).

- dev:

  If `TRUE`, add as dev dependencies.

- bioc:

  If `TRUE`, packages come from Bioconductor.

- do_lock:

  If `TRUE`, update the lockfile with the added package(s).

- do_install:

  If `TRUE`, install the added package(s). Ignored if `do_lock` is
  `FALSE`.

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

Other package managers: [`cache_clean()`](cache_clean.md),
[`export()`](export.md), [`import()`](import.md), [`lock()`](lock.md),
[`remove_pkgs()`](remove_pkgs.md), [`sync()`](sync.md),
[`update_pkgs()`](update_pkgs.md)

## Examples

``` r
if (FALSE) { # \dontrun{
add("ggplot2") # add to toml, lock, install
add("dplyr", do_lock = FALSE) # no lock, no install
add("dplyr", do_install = FALSE) # lock, no install
add("tidymodels@>=1.0.0")
add("user/repo@main")
add(c("ggplot2", "tidymodels@>=1.0.0", "user/repo@main"))
add(c("DESeq2", "GenomicRanges"), bioc = TRUE) # bioconductor
} # }
```
