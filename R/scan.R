#' Find packages your code uses but the manifest does not declare
#'
#' Scans the project's \code{.R}, \code{.Rmd} and \code{.qmd} files for
#' \code{library()}, \code{require()} and \code{pkg::fun()} usage, and reports
#' anything missing from \code{uvr.toml}. Equivalent to \code{uvr scan}.
#'
#' Useful straight after \code{\link{import}}, or on a project that predates
#' uvr, to catch dependencies nobody wrote down.
#'
#' @param all If \code{TRUE}, list every package found rather than only the
#'   ones missing from the manifest.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family package managers
#' @export
#' @examples
#' \dontrun{
#' scan()             # what's used but undeclared?
#' scan(all = TRUE)   # everything the scan found
#' }
scan <- function(all = FALSE, bin = NULL, dir = NULL, quiet = FALSE) {
  .validate_flags(list(all = all, quiet = quiet))
  .validate_single_characters(list(bin = bin, dir = dir), null_ok = TRUE)

  args <- "scan"
  if (isTRUE(all)) {
    args <- c(args, "--all")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
