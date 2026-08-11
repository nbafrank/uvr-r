# Show how to activate the project in a shell

Prints the line to source so that a bare `R` or `Rscript` in your
terminal uses this project's R and library. Equivalent to
`uvr activate`.

## Usage

``` r
activate(write_shim = FALSE, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- write_shim:

  If `TRUE`, (re)write the `.uvr/activate` shims rather than printing
  instructions. Useful for a project created before the shims existed,
  or if they were deleted.

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

## Details

This is inherently a \*shell\* operation: a process cannot change its
parent's environment, so calling this from R prints the command rather
than activating anything in the running session. Inside R you already
have the project library on
[`.libPaths()`](https://rdrr.io/r/base/libPaths.html) via the
`.Rprofile` that [`init`](init.md) writes — activation matters for the
terminal you launch `R` or `Rscript` from.

## Examples

``` r
if (FALSE) { # \dontrun{
activate()                    # print the `source .uvr/activate` line
activate(write_shim = TRUE)   # backfill the shims in an older project
} # }
```
