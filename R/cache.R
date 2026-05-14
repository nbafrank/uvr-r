#' Remove all cached package downloads
#'
#' Removes all installed packages and downloaded tarballs from the cache.
#' Equivalent to \code{uvr cache clean} on the command line.
#'
#' @param cache_dir Path to a custom cache directory. Defaults to \code{NULL}, 
#'   which is equivalent to \code{"~/.uvr/cache/"} if environmental variable \code{UVR_CACHE_DIR} is not set.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @export
cache_clean <- function(cache_dir = NULL, bin = NULL, quiet = FALSE) {
  stopifnot(
    is.null(cache_dir) || (is.character(cache_dir) && length(cache_dir) == 1L),
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.logical(quiet) && !is.na(quiet) && length(quiet) == 1L
  )

  env_cache_dir <- Sys.getenv("UVR_CACHE_DIR")
  if (env_cache_dir == "") {
    cache_dir <- cache_dir %||% "~/.uvr/cache/" # NULL swap
  }
  if (cache_dir != "~/.uvr/cache/") {
    Sys.setenv(UVR_CACHE_DIR = cache_dir)
    on.exit(Sys.setenv(UVR_CACHE_DIR = env_cache_dir), add = TRUE)
  }

  args <- c("cache", "clean")
  run_uvr(args, bin = bin, quiet = quiet)
}
