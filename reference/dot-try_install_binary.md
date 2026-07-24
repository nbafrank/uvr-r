# Try to download a pre-built binary from GitHub releases

Try to download a pre-built binary from GitHub releases

## Usage

``` r
.try_install_binary(
  tag = "latest",
  install_dir = .get_home_dir(),
  timeout = 60
)
```

## Arguments

- tag:

  Release tag, e.g. "v1.0.0". Defaults to latest release.

- install_dir:

  Directory to install into (default: home directory).

- timeout:

  Download timeout in seconds (default 60, matching
  [`utils::download.file()`](https://rdrr.io/r/utils/download.file.html)).
  Increase on slow connections, e.g. `install_uvr(timeout = 300)`. The R
  session's `timeout` option is restored on exit.

## Value

Path to binary or NULL if unavailable.
