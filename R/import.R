#' Import renv lockfile to create uvr.toml
#'
#' Converts \code{renv.lock} to \code{uvr.toml}.
#' Equivalent to \code{uvr import} on the command line.
#'
#' @param do_lock If \code{TRUE}, create \code{uvr.lock} as well.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family package managers
#' @export
#' @examples
#' \dontrun{
#' import()
#' import(do_lock = TRUE)  # create uvr.lock as well
#' }
import <- function(do_lock = FALSE, bin = NULL, dir = NULL, quiet = FALSE) {
  .validate_flags(list(do_lock = do_lock, quiet = quiet))
  .validate_single_characters(list(bin = bin, dir = dir), null_ok = TRUE)

  args <- "import"
  if (isTRUE(do_lock)) {
    args <- c(args, "--lock")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
