#' Run a uvr CLI command
#'
#' Internal helper that invokes uvr with the given arguments and streams
#' output to the R console.
#' Ensures that the uvr binary is found and up-to-date.
#'
#' @param args Character vector of CLI arguments.
#' @param bin Optional path to the uvr binary. If \code{NULL}, searches common locations using \code{\link{find_uvr}}.
#' @param dir Optional working directory. Defaults to \code{getwd()}.
#' @param quiet If \code{TRUE}, suppress output.
#' @return A character vector of output lines (returned invisibly).
#'   On failure, throws an error with the exit code.
#' @keywords internal
run_uvr <- function(args, bin = NULL, dir = NULL, quiet = FALSE) {
  .validate_multi_characters(list(args = args))
  .validate_single_characters(list(bin = bin, dir = dir), null_ok = TRUE)
  .validate_flags(list(quiet = quiet))
  bin <- bin %||% find_uvr # NULL
  .check_uvr_version(bin = path)

  if (!is.null(dir)) {
    old_wd <- setwd(dir)
    on.exit(setwd(old_wd), add = TRUE)
  }

  result <- .run_and_capture(bin = bin, args = args, quiet = quiet)
  if (result$return_code != 0L) {
    if (quiet && length(result$stderr) > 0L) {
      message(
        paste(result$stderr, collapse = "\n"),
        "\n",
        file = stderr(),
        sep = ""
      )
    }
    stop(sprintf("uvr exited with code %d", result$return_code), call. = FALSE)
  }

  invisible(result$stdout)
}
