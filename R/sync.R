#' Synchronize project library from lockfile
#'
#' Installs all packages specified in \code{uvr.lock}, skipping packages
#' that are already installed. From uvr 0.4.3, sync also removes packages
#' that are no longer in the lockfile from the project library (never from
#' \code{--library}/\code{UVR_LIBRARY} locations, which may be shared).
#' Equivalent to \code{uvr sync}.
#'
#' @param frozen If \code{TRUE}, fail if the lockfile is out of date (CI mode).
#' @param plan If \code{TRUE}, show the resolved install plan before
#'   installing: which source each package comes from and whether it installs
#'   from a binary or is built from source. Passes \code{-v}.
#' @inheritParams run_uvr
#' @inheritParams add
#' @inheritParams cache_clean
#' @inherit run_uvr return
#' @family package managers
#' @export
#' @examples
#' \dontrun{
#' sync()
#' sync(frozen = TRUE) # CI mode: fail if lockfile is stale
#' sync(plan = TRUE) # show what will install, and from where
#' sync(no_binary = TRUE) # build everything from source
#' sync(progress = "always") # force spinners even though output is piped
#' }
sync <- function(
  frozen = FALSE,
  no_binary = FALSE,
  install_system_deps = FALSE,
  plan = FALSE,
  bin = NULL,
  dir = NULL,
  cache_dir = NULL,
  progress = NULL,
  quiet = FALSE
) {
  .validate_flags(list(
    frozen = frozen,
    no_binary = no_binary,
    install_system_deps = install_system_deps,
    plan = plan,
    quiet = quiet
  ))
  .validate_single_characters(
    list(bin = bin, dir = dir, cache_dir = cache_dir),
    null_ok = TRUE
  )
  .setup_cache_dir(cache_dir)
  .setup_progress(progress)

  args <- "sync"
  if (isTRUE(frozen)) {
    args <- c(args, "--frozen")
  }
  if (isTRUE(no_binary)) {
    args <- c(args, "--no-binary")
  }
  if (isTRUE(install_system_deps)) {
    args <- c(args, "--install-system-deps")
  }
  # `-v` is a global flag, so it precedes the subcommand.
  if (isTRUE(plan)) {
    args <- c("-v", args)
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
