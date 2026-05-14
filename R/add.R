#' Add packages to the project
#'
#' Adds one or more packages to the manifest, updates the lockfile, and
#' installs them. Equivalent to \code{uvr add} on the command line.
#'
#' @param packages Character vector of package names (e.g. \code{c("ggplot2", "tidymodels@@>=1.0.0", "user/repo@@main")}).
#' @param dev If \code{TRUE}, add as dev dependencies.
#' @param bioc If \code{TRUE}, packages come from Bioconductor.
#' @param do_lock If \code{TRUE}, update the lockfile with the added package(s).
#' @param do_install If \code{TRUE}, install the added package(s).
#'   Ignored if \code{do_lock} is \code{FALSE}.
#' @inheritParams run_uvr
#' @inheritParams cache_clean
#' @inherit run_uvr return
#' @export
add <- function(
  packages,
  dev = FALSE,
  bioc = FALSE,
  do_lock = TRUE,
  do_install = TRUE,
  bin = NULL,
  dir = NULL,
  cache_dir = "~/.uvr/cache/",
  quiet = FALSE
) {
  stopifnot(
    is.character(packages) && length(packages) > 0L,
    is.logical(dev) && !is.na(dev) && length(dev) == 1L,
    is.logical(bioc) && !is.na(bioc) && length(bioc) == 1L,
    is.logical(do_install) && !is.na(do_install) && length(do_install) == 1L,
    is.logical(do_lock) && !is.na(do_lock) && length(do_lock) == 1L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.character(cache_dir) && length(cache_dir) == 1L,
    is.logical(quiet) && !is.na(quiet) && length(quiet) == 1L
  )

  if (cache_dir != "~/.uvr/cache/") {
    old_dir <- Sys.getenv("UVR_CACHE_DIR")
    Sys.setenv(UVR_CACHE_DIR = cache_dir)
    on.exit(Sys.setenv(UVR_CACHE_DIR = old_dir), add = TRUE)
  }

  args <- c("add", packages)
  if (isTRUE(dev)) {
    args <- c(args, "--dev")
  }
  if (isTRUE(bioc)) {
    args <- c(args, "--bioc")
  }
  if (isFALSE(do_lock)) {
    args <- c(args, "--no-lock")
  } else if (isFALSE(do_install)) {
    args <- c(args, "--no-install")
  }
  
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
