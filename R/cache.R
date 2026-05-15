#' Remove all cached package downloads
#'
#' Removes all installed packages and downloaded tarballs from the cache.
#' Equivalent to \code{uvr cache clean} on the command line.
#'
#' @param cache_dir Path to cache directory. Defaults to `NULL`, which uses 
#'   the `UVR_CACHE_DIR` environment variable if set, or `"~/.uvr/cache/"` otherwise.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family package managers
#' @export
#' @examples
#' \dontrun{
#' cache_clean()
#' # custom cache location - ensure used in other functions,
#' #   otherwise set env. var UVR_CACHE_DIR
#' cache_clean(cache_dir = "/tmp/uvr-cache/")
#' }
cache_clean <- function(cache_dir = NULL, bin = NULL, quiet = FALSE) {
  stopifnot(
    is.null(cache_dir) || (is.character(cache_dir) && length(cache_dir) == 1L),
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.logical(quiet) && !is.na(quiet) && length(quiet) == 1L
  )

  .setup_cache_dir(cache_dir)

  args <- c("cache", "clean")
  run_uvr(args, bin = bin, quiet = quiet)
}
