# Scope a uvr environment variable to the calling function

Scope a uvr environment variable to the calling function

## Usage

``` r
.setup_env_var(var, value, envir = parent.frame())
```

## Arguments

- var:

  Environment variable name, e.g. `"UVR_CACHE_DIR"`.

- value:

  Value to set, or NULL to leave the environment untouched.

- envir:

  Environment whose exit undoes the change.

## Value

NULL (side effects only)

## Details

Sets `var` for the duration of the calling function (via
[`withr::local_envvar`](https://withr.r-lib.org/reference/with_envvar.html)),
restoring the previous value — set or unset — when that function exits.
A `NULL` value is a no-op, so the CLI's own default / any user-set
environment variable stays in charge.
