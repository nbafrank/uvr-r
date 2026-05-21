# Install uvr via cargo

Install uvr via cargo

## Usage

``` r
.install_via_cargo(
  tag = "latest",
  install_dir = .get_home_dir(),
  force = FALSE
)
```

## Arguments

- tag:

  Release tag, e.g. "v1.0.0". Defaults to latest release.

- install_dir:

  Directory to install into (default: home directory).

## Value

Invisible path to the installed binary.
