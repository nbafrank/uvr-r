# Run a terminal command and capture the output cleanly

Run a terminal command and capture the output cleanly

## Usage

``` r
.run_and_capture(bin, args, quiet = FALSE)
```

## Arguments

- bin:

  Path to the binary to run

- args:

  Arguments to pass to the binary

- quiet:

  If `TRUE`, suppress output from the binary

## Value

A list with elements `stdout`, `stderr`, and `return_code`, captured
from the process.
