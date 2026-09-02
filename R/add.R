#' Add packages to the project
#'
#' Adds one or more packages to the manifest, updates the lockfile, and
#' installs them. Equivalent to \code{uvr add} on the command line.
#'
#' @param packages Character vector of package names (e.g. \code{c("ggplot2", "tidymodels@@>=1.0.0", "user/repo@@main")}).
#' @param dev If \code{TRUE}, add as dev dependencies.
#' @param bioc If \code{TRUE}, packages come from Bioconductor.
#' @param source Optional URL of a CRAN-like repository to take the
#'   package(s) from, e.g. \code{"https://community.r-multiverse.org"}. uvr
#'   records it as a \code{[[sources]]} entry in \code{uvr.toml}, so later
#'   resolves use it too. One URL per call.
#' @param no_binary If \code{TRUE}, build everything from source instead of
#'   using pre-built binaries — an escape hatch for a binary that does not
#'   suit the host.
#' @param install_system_deps If \code{TRUE}, let uvr install missing system
#'   libraries with the host package manager. Needs root or \code{sudo}, and
#'   uvr shows the full plan before running anything. Without this, missing
#'   system dependencies are reported and you install them yourself. Note that
#'   uvr only prompts for confirmation on a TTY: from R its output is piped,
#'   so it installs unattended, exactly as it does in CI.
#' @param do_lock If \code{TRUE}, update the lockfile with the added package(s).
#' @param do_install If \code{TRUE}, install the added package(s).
#'   Ignored if \code{do_lock} is \code{FALSE}.
#' @param progress Control uvr's progress display for this call:
#'   \code{"always"} forces spinners and progress bars even though output is
#'   piped (they are otherwise hidden because R captures uvr's output, so
#'   uvr never sees a TTY), \code{"never"} hides them. The default
#'   \code{NULL} leaves the \code{UVR_PROGRESS} environment variable in
#'   charge.
#' @inheritParams run_uvr
#' @inheritParams cache_clean
#' @inherit run_uvr return
#' @family package managers
#' @export
#' @examples
#' \dontrun{
#' add("ggplot2") # add to toml, lock, install
#' add("dplyr", do_lock = FALSE) # no lock, no install
#' add("dplyr", do_install = FALSE) # lock, no install
#' add("tidymodels@@>=1.0.0")
#' add("user/repo@@main")
#' add(c("ggplot2", "tidymodels@@>=1.0.0", "user/repo@@main"))
#' add(c("DESeq2", "GenomicRanges"), bioc = TRUE) # bioconductor
#' add("cli", source = "https://community.r-multiverse.org") # custom repo
#' add("xml2", install_system_deps = TRUE) # let uvr install libxml2
#' }
add <- function(
  packages,
  dev = FALSE,
  bioc = FALSE,
  do_lock = TRUE,
  do_install = TRUE,
  no_binary = FALSE,
  source = NULL,
  install_system_deps = FALSE,
  bin = NULL,
  dir = NULL,
  cache_dir = NULL,
  progress = NULL,
  quiet = FALSE
) {
  .validate_multi_characters(list(packages = packages))
  .validate_flags(list(
    dev = dev,
    bioc = bioc,
    do_lock = do_lock,
    do_install = do_install,
    no_binary = no_binary,
    install_system_deps = install_system_deps,
    quiet = quiet
  ))
  .validate_single_characters(
    list(
      source = source,
      bin = bin,
      dir = dir,
      cache_dir = cache_dir
    ),
    null_ok = TRUE
  )
  .setup_cache_dir(cache_dir)
  .setup_progress(progress)

  args <- c("add", packages)
  if (isTRUE(dev)) {
    args <- c(args, "--dev")
  }
  if (isTRUE(bioc)) {
    args <- c(args, "--bioc")
  }
  if (!is.null(source)) {
    args <- c(args, "--source", source)
  }
  if (isTRUE(no_binary)) {
    args <- c(args, "--no-binary")
  }
  if (isTRUE(install_system_deps)) {
    args <- c(args, "--install-system-deps")
  }
  if (isFALSE(do_lock)) {
    args <- c(args, "--no-lock")
  } else if (isFALSE(do_install)) {
    args <- c(args, "--no-install")
  }

  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
