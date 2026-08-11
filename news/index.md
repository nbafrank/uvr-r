# Changelog

## uvr 0.1.5

Catches the R package up with the uvr CLI, which reached 0.4.6 while
this package sat at 0.4.2-era coverage. `SystemRequirements` now asks
for uvr \>= 0.4.6.

### New functions

- [`tree()`](../reference/tree.md) shows the dependency graph
  (`uvr tree`), with an optional `depth`.
- [`scan()`](../reference/scan.md) finds packages your code uses but
  `uvr.toml` never declared (`uvr scan`) — useful right after
  [`import()`](../reference/import.md), or on a project that predates
  uvr.
- [`activate()`](../reference/activate.md) prints how to activate a
  project in a shell, and can backfill the shims in an older project
  with `write_shim = TRUE`.

### New arguments

- [`sync()`](../reference/sync.md) gains `plan` (show what will install
  and from where before it runs), `no_binary`, and
  `install_system_deps`.
- [`add()`](../reference/add.md) gains `no_binary`.
- [`r_install()`](../reference/r_install.md) gains `install_dir`, and
  now documents that it accepts partial versions (`"4.5"`) and the
  rolling channels (`"devel"`, `"next"`).

### Documentation

- [`run()`](../reference/run.md) documents standalone scripts: from uvr
  0.4.6 a script carrying a `# /// script` dependency header runs with
  no project at all, and [`run()`](../reference/run.md) handles those
  too.
