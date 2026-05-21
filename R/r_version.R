#' Install an R version
#'
#' Downloads and installs a specific R version to \code{~/.uvr/r-versions/}.
#' Equivalent to \code{uvr r install <version>} on the command line.
#'
#' @param version R version string, e.g. \code{"4.4.2"}.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family R version managers
#' @export
#' @examples
#' \dontrun{
#' r_install("4.4.2")
#' }
r_install <- function(version, bin = NULL, quiet = FALSE) {
  .validate_single_characters(list(version = version))
  .validate_single_characters(list(bin = bin), null_ok = TRUE)
  .validate_flags(list(quiet = quiet))

  args <- c("r", "install", version)
  run_uvr(args, bin = bin, quiet = quiet)
}

#' List R versions
#'
#' Shows installed R versions. Use \code{all = TRUE} to show all available
#' versions from CRAN.
#' Equivalent to \code{uvr r list} on the command line.
#'
#' @param all If \code{TRUE}, show all available versions (not just installed).
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family R version managers
#' @export
#' @examples
#' \dontrun{
#' r_list() # installed versions
#' r_list(all = TRUE) # available versions
#' }
r_list <- function(all = FALSE, bin = NULL, quiet = FALSE) {
  .validate_flags(list(all = all, quiet = quiet))
  .validate_single_characters(list(bin = bin), null_ok = TRUE)

  args <- c("r", "list")
  if (isTRUE(all)) {
    args <- c(args, "--all")
  }
  run_uvr(args, bin = bin, quiet = quiet)
}

#' Set the R version constraint
#'
#' Sets the R version constraint in \code{uvr.toml}.
#' Equivalent to \code{uvr r use <version>} on the command line.
#'
#' @param version Version constraint, e.g. \code{">=4.3.0"} or \code{"4.4.2"}.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family R version managers
#' @export
#' @examples
#' \dontrun{
#' r_use(">=4.3.0")
#' r_use("4.4.2")
#' }
r_use <- function(version, bin = NULL, dir = NULL, quiet = FALSE) {
  .validate_single_characters(list(version = version))
  .validate_single_characters(list(bin = bin, dir = dir), null_ok = TRUE)
  .validate_flags(list(quiet = quiet))

  args <- c("r", "use", version)
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}

#' Pin the R version
#'
#' Writes an exact R version to the \code{.r-version} file.
#' Equivalent to \code{uvr r pin <version>} on the command line.
#'
#' @inheritParams r_install
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family R version managers
#' @export
#' @examples
#' \dontrun{
#' r_pin("4.4.2")
#' }
r_pin <- function(version, bin = NULL, dir = NULL, quiet = FALSE) {
  .validate_single_characters(list(version = version))
  .validate_single_characters(list(bin = bin, dir = dir), null_ok = TRUE)
  .validate_flags(list(quiet = quiet))

  args <- c("r", "pin", version)
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
