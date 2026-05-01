#' Run a uvr CLI command
#'
#' Internal helper that invokes uvr with the given arguments and streams
#' output to the R console.
#'
#' @param args Character vector of CLI arguments.
#' @param bin Optional path to the uvr binary. If \code{NULL}, searches common locations using \code{\link{find_uvr}}.
#' @param dir Optional working directory. Defaults to \code{getwd()}.
#' @param quiet If \code{TRUE}, suppress output.
#' @return Invisible \code{TRUE} on success.
#' @keywords internal
run_uvr <- function(args, bin = NULL, dir = NULL, quiet = FALSE) {
  stopifnot(
    is.character(args) && length(args) > 0L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )

  if (is.null(bin)) {
    bin <- find_uvr()
  }

  if (!is.null(dir)) {
    old_wd <- setwd(dir)
    on.exit(setwd(old_wd), add = TRUE)
  }

  if (isTRUE(quiet)) {
    return_code <- system2(bin, args, stdout = FALSE, stderr = FALSE)
  } else {
    return_code <- system2(bin, args, stdout = "", stderr = "")
  }

  if (return_code != 0L) {
    stop("uvr exited with code ", return_code, call. = FALSE)
  }
  invisible(TRUE)
}
