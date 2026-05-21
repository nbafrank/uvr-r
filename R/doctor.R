#' Diagnose environment issues (R, build tools, project status)
#'
#' Equivalent to \code{uvr doctor} on the command line.
#'
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family uvr setup functions
#' @export
#' @examples
#' \dontrun{
#' doctor()
#' }
doctor <- function(bin = NULL, dir = NULL, quiet = FALSE) {
  .validate_single_characters(list(bin = bin, dir = dir), null_ok = TRUE)
  .validate_flags(list(quiet = quiet))

  args <- c("doctor")
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
