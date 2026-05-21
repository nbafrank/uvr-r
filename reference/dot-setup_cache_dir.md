# Set up cache directory environment variable

Set up cache directory environment variable

## Usage

``` r
.setup_cache_dir(cache_dir, envir = parent.frame())
```

## Arguments

- cache_dir:

  User-provided cache directory or NULL

## Value

NULL (side effects only)

## Details

creates a side effect of setting the `UVR_CACHE_DIR` environment
variable, then unsetting it when parent function closes
