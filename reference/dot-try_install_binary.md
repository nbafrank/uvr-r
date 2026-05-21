# Try to download a pre-built binary from GitHub releases

Try to download a pre-built binary from GitHub releases

## Usage

``` r
.try_install_binary(tag = "latest", install_dir = .get_home_dir())
```

## Arguments

- tag:

  Release tag, e.g. "v1.0.0". Defaults to latest release.

- install_dir:

  Directory to install into (default: home directory).

## Value

Path to binary or NULL if unavailable.
