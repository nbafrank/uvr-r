# Download and extract uvr binary

Download and extract uvr binary

## Usage

``` r
.get_and_extract_binary(download_url, dest_dir, timeout = 60)
```

## Arguments

- timeout:

  Download timeout in seconds (default 60, matching
  [`utils::download.file()`](https://rdrr.io/r/utils/download.file.html)).
  Increase on slow connections, e.g. `install_uvr(timeout = 300)`. The R
  session's `timeout` option is restored on exit.

## Value

Destination path or NULL if download failed. A download that hits the
timeout errors instead of returning NULL, so the caller does not fall
through to the misleading "no pre-built binary" path.
