#' Run an R script in the project environment
#'
#' Executes a script with the project library active.
#' Equivalent to \code{uvr run script.R} on the command line.
#' For interactive R, use the CLI directly: \code{uvr run}.
#'
#' From uvr 0.4.6 a script may instead declare its own dependencies in a
#' header comment and run with no project at all:
#'
#' \preformatted{
#' # /// script
#' # dependencies = ["jsonlite", "praise"]
#' # ///
#' cat(praise::praise(), "\n")
#' }
#'
#' \code{run()} handles those too. The dependencies install into a cached
#' environment keyed by the dependency set, so repeat runs start
#' immediately and nothing is written beside the script. Such a script is
#' isolated from any surrounding project — its library, \code{.r-version}
#' pin and \code{.Rprofile} are all bypassed — so it behaves the same
#' wherever it is run from.
#'
#' @param script Path to an R script.
#' @param args Character vector of arguments forwarded to the script. Defaults to \code{NULL} for no arguments.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @export
#' @examples
#' \dontrun{
#' run("analysis.R")
#' run("model.R", args = c("--seed", "42"))
#' run("standalone.R") # script carries its own `# /// script` header
#' }
run <- function(
  script,
  args = NULL,
  bin = NULL,
  dir = NULL,
  quiet = FALSE
) {
  .validate_single_characters(list(script = script))
  .validate_multi_characters(list(args = args), null_ok = TRUE)
  .validate_single_characters(list(bin = bin, dir = dir), null_ok = TRUE)
  .validate_flags(list(quiet = quiet))

  cli_args <- c("run", script)
  if (length(args) > 0L) {
    cli_args <- c(cli_args, "--", args)
  }
  run_uvr(cli_args, bin = bin, dir = dir, quiet = quiet)
}
