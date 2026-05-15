#' Remove packages from the project
#'
#' Removes one or more packages from the manifest and updates the lockfile.
#' Equivalent to \code{uvr remove} on the command line.
#'
#' @inheritParams add
#' @inheritParams run_uvr
#' @inheritParams sync
#' @inherit run_uvr return
#' @export
#' @family package managers
#' @examples
#' \dontrun{
#' remove_pkgs("ggplot2")
#' remove_pkgs(c("dplyr", "tidyr"))
#' }
remove_pkgs <- function(
  packages,
  bin = NULL,
  dir = NULL,
  lib_dir = NULL,
  quiet = FALSE
) {
  .validate_multi_characters(list(packages = packages))
  .validate_single_characters(
    list(bin = bin, dir = dir, lib_dir = lib_dir),
    null_ok = TRUE
  )
  .validate_flags(list(quiet = quiet))
  .temp_setenv(list(UVR_LIBRARY = lib_dir))

  args <- c("remove", packages)
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
