#' Remove cached package downloads
#'
#' With no filters, removes all installed packages and downloaded tarballs
#' from the cache. With filters, removes only the entries that match every
#' given filter (requires uvr >= 0.4.2).
#' Equivalent to \code{uvr cache clean [--package <name>] [--r-version <minor>]}
#' on the command line.
#'
#' @param package Optional character vector of package names: remove only
#'   cache entries for these packages.
#' @param r_version Optional character vector of R minor versions (e.g.
#'   \code{"4.4"}): remove only cache entries built for these R series.
#'   Full versions like \code{"4.4.2"} are treated as their minor series.
#' @param cache_dir Path to cache directory. Defaults to `NULL`, which uses
#'   the `UVR_CACHE_DIR` environment variable if set, or `"~/.uvr/cache/"` otherwise.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family package managers
#' @export
#' @examples
#' \dontrun{
#' cache_clean() # remove everything
#' cache_clean(package = "sf") # one package's entries only
#' cache_clean(r_version = "4.4") # one R series only
#' cache_clean(package = c("sf", "terra"), r_version = "4.5")
#' # custom cache location - ensure used in other functions,
#' #   otherwise set env. var UVR_CACHE_DIR
#' cache_clean(cache_dir = "/tmp/uvr-cache/")
#' }
cache_clean <- function(
  package = NULL,
  r_version = NULL,
  cache_dir = NULL,
  bin = NULL,
  quiet = FALSE
) {
  .validate_multi_characters(
    list(package = package, r_version = r_version),
    null_ok = TRUE
  )
  .validate_single_characters(
    list(bin = bin, cache_dir = cache_dir),
    null_ok = TRUE
  )
  .validate_flags(list(quiet = quiet))
  .setup_cache_dir(cache_dir)

  args <- c("cache", "clean")
  for (pkg in package) {
    args <- c(args, "--package", pkg)
  }
  for (ver in r_version) {
    args <- c(args, "--r-version", ver)
  }
  run_uvr(args, bin = bin, quiet = quiet)
}
