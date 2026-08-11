#' Show how to activate the project in a shell
#'
#' Prints the line to source so that a bare \code{R} or \code{Rscript} in your
#' terminal uses this project's R and library. Equivalent to
#' \code{uvr activate}.
#'
#' This is inherently a *shell* operation: a process cannot change its
#' parent's environment, so calling this from R prints the command rather
#' than activating anything in the running session. Inside R you already have
#' the project library on \code{.libPaths()} via the \code{.Rprofile} that
#' \code{\link{init}} writes — activation matters for the terminal you launch
#' \code{R} or \code{Rscript} from.
#'
#' @param write_shim If \code{TRUE}, (re)write the \code{.uvr/activate} shims
#'   rather than printing instructions. Useful for a project created before
#'   the shims existed, or if they were deleted.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family project setup
#' @export
#' @examples
#' \dontrun{
#' activate()                    # print the `source .uvr/activate` line
#' activate(write_shim = TRUE)   # backfill the shims in an older project
#' }
activate <- function(
  write_shim = FALSE,
  bin = NULL,
  dir = NULL,
  quiet = FALSE
) {
  .validate_flags(list(write_shim = write_shim, quiet = quiet))
  .validate_single_characters(list(bin = bin, dir = dir), null_ok = TRUE)

  args <- "activate"
  if (isTRUE(write_shim)) {
    args <- c(args, "--write-shim")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
