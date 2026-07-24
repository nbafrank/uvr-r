# Update uvr (R package + CLI binary)

Convenience helper that updates both the `uvr` R companion package and
the underlying `uvr` CLI binary in one call.

## Usage

``` r
update_uvr(
  ref = "HEAD",
  method = c("auto", "binary", "cargo"),
  install_dir = NULL,
  package_dir = .libPaths()[1],
  quiet = FALSE,
  timeout = 60
)
```

## Arguments

- ref:

  Git ref (branch, tag, commit SHA) to install the R package from.
  Defaults to the default branch (`"HEAD"`).

- method:

  Installation method: `"auto"` (default) tries a pre-built GitHub
  release binary first, then falls back to building from source via
  `cargo install`. `"binary"` downloads a pre-built binary only.
  `"cargo"` builds from source only.

- install_dir:

  Directory to install into (default: home directory).

- package_dir:

  Path to the library directory where to install/update the package.

- quiet:

  If `TRUE`, suppress progress messages.

- timeout:

  Download timeout in seconds (default 60, matching
  [`utils::download.file()`](https://rdrr.io/r/utils/download.file.html)).
  Increase on slow connections, e.g. `install_uvr(timeout = 300)`. The R
  session's `timeout` option is restored on exit.

## Value

Invisible named list with `r_package` (installed version or `NA` on
failure) and `binary` (path to the CLI binary).

## Details

Requires either the pak or remotes package to update the R companion
package from GitHub.

The function does *not* automatically restart your R session. After it
completes, you will need to restart R to load the newly installed
package (i.e. `.rs.restartR()` (RStudio) or
`rstudioapi::restartSession()`).

## See also

Other uvr setup functions: [`completions()`](completions.md),
[`doctor()`](doctor.md), [`init()`](init.md),
[`install_uvr()`](install_uvr.md)

## Examples

``` r
if (FALSE) { # \dontrun{
update_uvr()
# then restart R to pick up the new package
} # }
```
