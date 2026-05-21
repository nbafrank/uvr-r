# Install the uvr binary

Downloads and installs the `uvr` binary. By default, tries to download a
pre-built binary from GitHub releases. If not available for the current
platform, falls back to building from source via `cargo install`
(requires the Rust toolchain).

## Usage

``` r
install_uvr(
  tag = "latest",
  method = c("auto", "binary", "cargo"),
  install_dir = NULL,
  force = FALSE
)
```

## Arguments

- tag:

  Release tag, e.g. "v1.0.0". Defaults to latest release.

- method:

  Installation method: `"auto"` (default) tries a pre-built GitHub
  release binary first, then falls back to building from source via
  `cargo install`. `"binary"` downloads a pre-built binary only.
  `"cargo"` builds from source only.

- install_dir:

  Directory to install into (default: home directory).

- force:

  If `TRUE`, reinstall even if uvr is already present.

## Value

Invisible path to the installed binary.

## See also

Other uvr setup functions: [`completions()`](completions.md),
[`doctor()`](doctor.md), [`init()`](init.md),
[`update_uvr()`](update_uvr.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Auto-detect best method
install_uvr()

# Force rebuild from source
install_uvr(method = "cargo", force = TRUE)
} # }
```
