# Search common locations for the uvr binary

Search common locations for the uvr binary

## Usage

``` r
.find_uvr_path(install_dir = .get_home_dir(), check_path = TRUE)
```

## Arguments

- install_dir:

  Directory to install into (default: home directory).

- check_path:

  If `TRUE`, check the PATH first.

## Value

Path string or NULL if not found.
