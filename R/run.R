#' Run an R script in the project environment
#'
#' Executes a script with the project library active.
#' Equivalent to \code{uvr run script.R} on the command line.
#' For interactive R, use the CLI directly: \code{uvr run}.
#'
#' @param script Path to an R script.
#' @param args Character vector of arguments forwarded to the script.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @export
#' @examples
#' \dontrun{
#' run("analysis.R")
#' run("model.R", args = c("--seed", "42"))
#' }
run <- function(
  script,
  args = character(),
  bin = NULL,
  dir = NULL,
  quiet = FALSE
) {
  .validate_single_characters(list(script = script))
  .validate_multi_characters(list(args = args))
  .validate_single_characters(list(bin = bin, dir = dir), null_ok = TRUE)
  .validate_flags(list(quiet = quiet))

  cli_args <- c("run", script)
  if (length(args) > 0L) {
    cli_args <- c(cli_args, "--", args)
  }
  run_uvr(cli_args, bin = bin, dir = dir, quiet = quiet)
}
