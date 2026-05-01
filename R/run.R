#' Run an R script in the project environment
#'
#' Executes a script with the project library active.
#' Equivalent to \code{uvr run script.R} on the command line.
#' For interactive R, use the CLI directly: \code{uvr run}.
#'
#' @param script Path to an R script.
#' @param args Character vector of arguments forwarded to the script.
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
#' @examples
#' \dontrun{
#' run("analysis.R")
#' run("model.R", args = c("--seed", "42"))
#' }
run <- function(script, args = character(), dir = NULL, quiet = FALSE) {
  stopifnot(
    is.character(script) && length(script) == 1L,
    is.character(args) && length(args) >= 0L,
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )

  cli_args <- c("run", script)
  if (length(args) > 0L) {
    cli_args <- c(cli_args, "--", args)
  }
  run_uvr(cli_args, dir = dir, quiet = quiet)
}
