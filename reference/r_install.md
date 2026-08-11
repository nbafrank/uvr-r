# Install an R version

Downloads and installs a specific R version to `~/.uvr/r-versions/`.
Equivalent to `uvr r install <version>` on the command line.

## Usage

``` r
r_install(version, install_dir = NULL, bin = NULL, quiet = FALSE)
```

## Arguments

- version:

  R version string. A full `"4.4.2"`, a partial `"4.5"` (installs the
  newest 4.5.x), or a rolling channel — `"devel"` or `"next"`. Rolling
  channels are rebuilt continuously, so pinning one is not reproducible;
  uvr marks them `[unstable]` and warns at install time.

- install_dir:

  Optional directory to install into, instead of `~/.uvr/r-versions/`.
  Takes precedence over the `UVR_R_INSTALL_DIR` environment variable.
  Note that the other `r_*()` functions discover installs through that
  environment variable, so a custom directory wants both set to the same
  place.

- bin:

  Optional path to the uvr binary. If `NULL`, searches common locations
  using [`find_uvr`](find_uvr.md).

- quiet:

  If `TRUE`, suppress output.

## Value

A character vector of output lines (returned invisibly). On failure,
throws an error with the exit code.

## See also

Other R version managers: [`r_list()`](r_list.md),
[`r_pin()`](r_pin.md), [`r_use()`](r_use.md)

## Examples

``` r
if (FALSE) { # \dontrun{
r_install("4.4.2")
r_install("4.5") # newest 4.5.x
r_install("devel") # rolling channel, not reproducible
r_install("4.4.2", install_dir = "/opt/R")
} # }
```
