# uvr (development version)

## New arguments

* `add()` gains `source` (take the package from a CRAN-like repository,
  recorded as a `[[sources]]` entry in `uvr.toml`) and
  `install_system_deps`, which `sync()` already had.

# uvr 0.1.5

Catches the R package up with the uvr CLI, which reached 0.4.6 while this
package sat at 0.4.2-era coverage. `SystemRequirements` now asks for
uvr >= 0.4.6.

## New functions

* `tree()` shows the dependency graph (`uvr tree`), with an optional
  `depth`.
* `scan()` finds packages your code uses but `uvr.toml` never declared
  (`uvr scan`) — useful right after `import()`, or on a project that
  predates uvr.
* `activate()` prints how to activate a project in a shell, and can
  backfill the shims in an older project with `write_shim = TRUE`.

## New arguments

* `sync()` gains `plan` (show what will install and from where before it
  runs), `no_binary`, and `install_system_deps`.
* `add()` gains `no_binary`.
* `r_install()` gains `install_dir`, and now documents that it accepts
  partial versions (`"4.5"`) and the rolling channels (`"devel"`,
  `"next"`).

## Documentation

* `run()` documents standalone scripts: from uvr 0.4.6 a script carrying
  a `# /// script` dependency header runs with no project at all, and
  `run()` handles those too.
