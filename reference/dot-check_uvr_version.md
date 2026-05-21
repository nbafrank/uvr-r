# Check that uvr binary version is recent enough

Check that uvr binary version is recent enough

## Usage

``` r
.check_uvr_version(bin = NULL)
```

## Arguments

- bin:

  Optional path to the uvr binary. If `NULL`, searches common locations
  using [`find_uvr`](find_uvr.md).

## Details

Checks the SystemRequirements field of the package description to ensure
that the uvr binary is recent enough.
