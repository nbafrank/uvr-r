#' Show the dependency tree
#'
#' Prints the project's resolved dependency tree, so you can see which
#' package pulled in a transitive dependency. Equivalent to \code{uvr tree}.
#'
#' @param depth Optional maximum depth to display. \code{1} shows only
#'   direct dependencies.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family package managers
#' @export
#' @examples
#' \dontrun{
#' tree()
#' tree(depth = 1)  # direct dependencies only
#' }
tree <- function(depth = NULL, bin = NULL, dir = NULL, quiet = FALSE) {
  .validate_flags(list(quiet = quiet))
  .validate_single_characters(list(bin = bin, dir = dir), null_ok = TRUE)
  if (!is.null(depth)) {
    .validate_positive_numbers(list(depth = depth))
  }

  args <- "tree"
  if (!is.null(depth)) {
    args <- c(args, "--depth", as.character(as.integer(depth)))
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
