# Scope UVR_PROGRESS to the calling function

Scope UVR_PROGRESS to the calling function

## Usage

``` r
.setup_progress(progress, envir = parent.frame())
```

## Arguments

- envir:

  Environment whose exit undoes the change.

## Details

Validates and applies the \`progress\` argument shared by
[`add`](add.md) and [`sync`](sync.md): `"always"` or `"never"`, or NULL
to leave the environment in charge.
