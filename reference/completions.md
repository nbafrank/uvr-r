# Generate shell completions (bash, zsh, fish, powershell)

Equivalent to `` uvr completions `shell` `` on the command line.

## Usage

``` r
completions(
  shell = c("bash", "zsh", "fish", "powershell"),
  bin = NULL,
  quiet = FALSE
)
```

## Arguments

- shell:

  One of `"bash"`, `"zsh"`, `"fish"`, or `"powershell"`.

- bin:

  Optional path to the uvr binary. If `NULL`, searches common locations
  using [`find_uvr`](find_uvr.md).

- quiet:

  If `TRUE`, suppress output.

## Value

A character vector of output lines (returned invisibly). On failure,
throws an error with the exit code.

## See also

Other uvr setup functions: [`doctor()`](doctor.md), [`init()`](init.md),
[`install_uvr()`](install_uvr.md), [`update_uvr()`](update_uvr.md)

## Examples

``` r
if (FALSE) { # \dontrun{
completions("bash")
completions("zsh")
completions("fish")
completions("powershell")
} # }
```
