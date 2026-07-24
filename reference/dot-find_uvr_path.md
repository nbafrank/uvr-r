# Search common locations for the uvr binary

Search common locations for the uvr binary

## Usage

``` r
.find_uvr_path(
  install_dir = .get_home_dir(),
  check_path = TRUE,
  system_fallbacks = TRUE
)
```

## Arguments

- install_dir:

  Directory to install into (default: home directory).

- check_path:

  If `TRUE`, check the PATH first.

- system_fallbacks:

  If `TRUE`, also check system-wide locations (`/usr/local/bin`,
  Homebrew, `LOCALAPPDATA`) beyond `install_dir`. Set to `FALSE` when
  the caller asked about a specific `install_dir` and a binary elsewhere
  must not count — e.g. `install_uvr(install_dir = ...)`'s
  already-installed check, which would otherwise early-return on a
  system uvr and never install into the requested directory.

## Value

Path string or NULL if not found.
