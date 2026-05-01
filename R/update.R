#' Update uvr (R package + CLI binary)
#'
#' Convenience helper that updates both the \code{uvr} R companion package
#' and the underlying \code{uvr} CLI binary in one call.
#'
#' The function does \emph{not} automatically restart your R session. After
#' it completes, you will need to restart R to load the newly installed package.
#'
#' @param quiet If \code{TRUE}, suppress progress messages.
#' @inheritParams install_uvr
#' @inheritParams .update_uvr_pkg
#' @return Invisible named list with \code{r_package} (installed version or
#'   \code{NA} on failure) and \code{binary} (path to the CLI binary).
#' @export
#' @examples
#' \dontrun{
#' update_uvr()
#' # then restart R to pick up the new package
#' }
update_uvr <- function(ref = "HEAD", method = "auto", quiet = FALSE) {
  stopifnot(
    is.character(ref) && length(ref) == 1L,
    is.character(method) && length(method) == 1L,
    is.logical(quiet) && length(quiet) == 1L
  )

  # Update R package
  if (!quiet) {
    message("Updating uvr R package from GitHub (ref: ", ref, ")...")
  }
  .update_uvr_pkg(ref = ref)

  # Update CLI binary
  if (!quiet) {
    message("Updating uvr CLI binary...")
  }
  bin <- install_uvr(method = method, force = TRUE)

  # Query version without loading (DESCRIPTION already on disk post-install)
  r_pkg_version <- tryCatch(
    as.character(utils::packageVersion("uvr")),
    error = function(e) NA_character_
  )

  # Summarize and return
  if (!quiet) {
    message(
      "\nuvr update complete.",
      "\n  R package : ",
      r_pkg_version,
      "\n  CLI binary: ",
      bin,
      "\n",
      "\nRestart your R session to use the updated package."
    )
  }
  invisible(list(r_package = r_pkg_version, binary = bin))
}

#' Update uvr R package
#' @param ref Git ref (branch, tag, commit SHA) to install the R package from.
#'   Defaults to the default branch (\code{"HEAD"}).
#' @keywords internal
.update_uvr_pkg <- function(ref = "HEAD") {
  repo_spec <- if (identical(ref, "HEAD") || is.null(ref)) {
    "nbafrank/uvr-r"
  } else {
    paste0("nbafrank/uvr-r@", ref)
  }

  # Prefer pak if available (faster, better diagnostics); fall back to remotes
  r_pkg_version <- NA_character_
  if (requireNamespace("pak", quietly = TRUE)) {
    pak::pak(repo_spec)
  } else if (requireNamespace("remotes", quietly = TRUE)) {
    remotes::install_github(repo_spec)
  } else {
    stop(
      "Could not update the uvr R package. Install either the {pak} or {remotes} package first:\n",
      "  install.packages(\"pak\")    # or\n",
      "  install.packages(\"remotes\")",
      call. = FALSE
    )
  }
}
