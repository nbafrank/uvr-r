# Get the name of a binary for Unix or Windows (+".exe")

Get the name of a binary for Unix or Windows (+".exe")

## Usage

``` r
.get_bin_name(name = "uvr", os_type = .Platform$OS.type)
```

## Arguments

- name:

  Name of binary to return OS-specific name for (default: "uvr")

- os_type:

  OS type, defaults to `.Platform$OS.type`.

## Value

OS-specific name of the binary (i.e. "uvr" or "uvr.exe").
