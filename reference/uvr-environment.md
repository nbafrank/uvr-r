# Environment variables used by uvr

Environment variables used by uvr

## UVR_CACHE_DIR

Directory where uvr stores cached packages, environments, and tarballs.
Expects a valid absolute or relative directory path. Defaults to
`~/.uvr/cache/` if not set.

## UVR_EXTRA_LIBS

A list of extra R library paths appended to the `R_LIBS_USER` search
path when executing `uvr run`. Expects a string of paths separated by
the standard OS path separator (`:` on Unix/macOS, `;` on Windows).

## UVR_INSTALL_DIR

Directory in which to install `uvr` using the standalone shell
installer. Not used by this R package: [`install_uvr`](install_uvr.md)
takes an `install_dir` argument instead.

## UVR_INSTALL_TIMEOUT

Overrides the default per-package installation timeout (30 minutes).
Expects a duration string such as `30m`, `2h`, `90s`, or a bare number
representing seconds (e.g. `1800`).

## UVR_LIBRARY

Custom target directory for R package installations. Note: the CLI
`--library` argument takes precedence over this variable. Defaults to
the project-local `.uvr/library/` directory if neither are provided.

## UVR_PACKAGES_DIR

Directory where uvr stores cached installed-package entries. Expects a
valid absolute or relative directory path. Defaults to
`~/.uvr/packages/` if not set. (Requires uvr \>= 0.4.2.)

## UVR_PROGRESS

Controls the visibility of progress bars and spinners in the terminal.
Acceptable values:

- `always`, `1`, `true`: Forces progress to be drawn, bypassing TTY
  checks (useful for SSH).

- `never`, `0`, `false`: Forces progress to be hidden (useful for CI
  logs).

Defaults to automatically detecting a TTY.

## UVR_R_INSTALL_DIR

Directory where uvr-managed R versions are installed. Expects a valid
absolute or relative directory path. Defaults to `~/.uvr/r-versions/` if
not set.

## UVR_REPOS

Comma-separated list of CRAN-like repository URLs used in addition to
(and at higher priority than) any `[[sources]]` in `uvr.toml`. Useful
for injecting repositories via CI environment instead of mutating the
manifest.
