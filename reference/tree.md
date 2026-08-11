# Show the dependency tree

Prints the project's resolved dependency tree, so you can see which
package pulled in a transitive dependency. Equivalent to `uvr tree`.

## Usage

``` r
tree(depth = NULL, bin = NULL, dir = NULL, quiet = FALSE)
```

## Arguments

- depth:

  Optional maximum depth to display. `1` shows only direct dependencies.

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

Other package managers: [`add()`](add.md),
[`cache_clean()`](cache_clean.md), [`export()`](export.md),
[`import()`](import.md), [`lock()`](lock.md),
[`remove_pkgs()`](remove_pkgs.md), [`scan()`](scan.md),
[`sync()`](sync.md), [`update_pkgs()`](update_pkgs.md)

## Examples

``` r
if (FALSE) { # \dontrun{
tree()
tree(depth = 1)  # direct dependencies only
} # }
```
