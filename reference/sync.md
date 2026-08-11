# Synchronize project library from lockfile

Installs all packages specified in `uvr.lock`, skipping packages that
are already installed. From uvr 0.4.3, sync also removes packages that
are no longer in the lockfile from the project library (never from
`--library`/`UVR_LIBRARY` locations, which may be shared). Equivalent to
`uvr sync`.

## Usage

``` r
sync(
  frozen = FALSE,
  no_binary = FALSE,
  install_system_deps = FALSE,
  plan = FALSE,
  bin = NULL,
  dir = NULL,
  cache_dir = NULL,
  progress = NULL,
  quiet = FALSE
)
```

## Arguments

- frozen:

  If `TRUE`, fail if the lockfile is out of date (CI mode).

- no_binary:

  If `TRUE`, build everything from source instead of using pre-built
  binaries — an escape hatch for a binary that does not suit the host.

- install_system_deps:

  If `TRUE`, let uvr install missing system libraries with the host
  package manager. Needs root or `sudo`, and uvr shows the full plan
  before running anything. Without this, missing system dependencies are
  reported and you install them yourself.

- plan:

  If `TRUE`, show the resolved install plan before installing: which
  source each package comes from and whether it installs from a binary
  or is built from source. Passes `-v`.

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

- progress:

  Control uvr's progress display for this call: `"always"` forces
  spinners and progress bars even though output is piped (they are
  otherwise hidden because R captures uvr's output, so uvr never sees a
  TTY), `"never"` hides them. The default `NULL` leaves the
  `UVR_PROGRESS` environment variable in charge.

- quiet:

  If `TRUE`, suppress output.

## Value

A character vector of output lines (returned invisibly). On failure,
throws an error with the exit code.

## See also

Other package managers: [`add()`](add.md),
[`cache_clean()`](cache_clean.md), [`export()`](export.md),
[`import()`](import.md), [`lock()`](lock.md),
[`remove_pkgs()`](remove_pkgs.md), [`scan()`](scan.md),
[`tree()`](tree.md), [`update_pkgs()`](update_pkgs.md)

## Examples

``` r
if (FALSE) { # \dontrun{
sync()
sync(frozen = TRUE) # CI mode: fail if lockfile is stale
sync(plan = TRUE) # show what will install, and from where
sync(no_binary = TRUE) # build everything from source
sync(progress = "always") # force spinners even though output is piped
} # }
```
