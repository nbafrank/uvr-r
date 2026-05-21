# Initialize a new uvr project

Creates a `uvr.toml` manifest and `.uvr/library/` directory. Also
generates `.Rprofile` code to link to the `.uvr/library/` on session
start. Equivalent to `uvr init` on the command line.

## Usage

``` r
init(name = NULL, r_version = NULL, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- name:

  Optional project name. Defaults to the current directory name.

- r_version:

  Optional R version constraint, e.g. `">=4.3.0"`.

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

Other uvr setup functions: [`completions()`](completions.md),
[`doctor()`](doctor.md), [`install_uvr()`](install_uvr.md),
[`update_uvr()`](update_uvr.md)

## Examples

``` r
if (FALSE) { # \dontrun{
init()
init(name = "my-project", r_version = ">=4.3.0")
} # }
```
