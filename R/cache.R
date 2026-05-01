#' Remove all cached package downloads
#'
#' Removes all installed packages and downloaded tarballs from the cache.
#' Equivalent to \code{uvr cache clean} on the command line.
#'
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
cache_clean <- function(bin = NULL, quiet = FALSE) {
  stopifnot(
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )

  args <- c("cache", "clean")
  run_uvr(args, bin = bin, quiet = quiet)
}
