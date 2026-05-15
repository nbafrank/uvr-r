#' Run a uvr CLI command
#'
#' Internal helper that invokes uvr with the given arguments and streams
#' output to the R console.
#'
#' @param args Character vector of CLI arguments.
#' @param bin Optional path to the uvr binary. If \code{NULL}, searches common locations using \code{\link{find_uvr}}.
#' @param dir Optional working directory. Defaults to \code{getwd()}.
#' @param quiet If \code{TRUE}, suppress output.
#' @return A character vector of output lines (returned invisibly). 
#'   On failure, throws an error with the exit code.
#' @keywords internal
run_uvr <- function(args, bin = NULL, dir = NULL, quiet = FALSE) {
  stopifnot(
    is.character(args) && length(args) > 0L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && !is.na(quiet) && length(quiet) == 1L
  )

  if (is.null(bin)) {
    bin <- find_uvr()
  }

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
