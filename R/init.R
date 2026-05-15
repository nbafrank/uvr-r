#' Initialize a new uvr project
#'
#' Creates a \code{uvr.toml} manifest and \code{.uvr/library/} directory.
#' Also generates \code{.Rprofile} code to link to the \code{.uvr/library/} on session start.
#' Equivalent to \code{uvr init} on the command line.
#'
#' @param name Optional project name. Defaults to the current directory name.
#' @param r_version Optional R version constraint, e.g. \code{">=4.3.0"}.
#' @inheritParams run_uvr
#' @inheritParams sync
#' @inherit run_uvr return
#' @family uvr setup functions
#' @export
#' @examples
#' \dontrun{
#' init()
#' init(name = "my-project", r_version = ">=4.3.0")
#' }
init <- function(
  name = NULL,
  r_version = NULL,
  bin = NULL,
  dir = NULL,
  lib_dir = NULL,
  quiet = FALSE
) {
  .validate_single_characters(
    list(
      name = name,
      r_version = r_version,
      bin = bin,
      dir = dir,
      lib_dir = lib_dir
    ),
    null_ok = TRUE
  )
  .validate_flags(list(quiet = quiet))
  .temp_setenv(list(UVR_LIBRARY = lib_dir))

  args <- "init"
  if (!is.null(name)) {
    args <- c(args, name)
  }
  if (!is.null(r_version)) {
    args <- c(args, "--r-version", r_version)
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
