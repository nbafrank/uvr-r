# Run an R script in the project environment

Executes a script with the project library active. Equivalent to
`uvr run script.R` on the command line. For interactive R, use the CLI
directly: `uvr run`.

## Usage

``` r
run(script, args = NULL, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- script:

  Path to an R script.

- args:

  Character vector of arguments forwarded to the script. Defaults to
  `NULL` for no arguments.

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

From uvr 0.4.6 a script may instead declare its own dependencies in a
header comment and run with no project at all:


    # /// script
    # dependencies = ["jsonlite", "praise"]
    # ///
    cat(praise::praise(), "\n")

`run()` handles those too. The dependencies install into a cached
environment keyed by the dependency set, so repeat runs start
immediately and nothing is written beside the script. Such a script is
isolated from any surrounding project — its library, `.r-version` pin
and `.Rprofile` are all bypassed — so it behaves the same wherever it is
run from.

## Examples

``` r
if (FALSE) { # \dontrun{
run("analysis.R")
run("model.R", args = c("--seed", "42"))
run("standalone.R") # script carries its own `# /// script` header
} # }
```
