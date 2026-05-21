#' Environment variables used by uvr
#'
#' @section UVR_CACHE_DIR:
#'   Directory where uvr stores cached packages, environments, and tarballs.
#'   Expects a valid absolute or relative directory path.
#'   Defaults to \code{~/.uvr/cache/} if not set.
#'
#' @section UVR_EXTRA_LIBS:
#'   A list of extra R library paths appended to the \code{R_LIBS_USER} search
#'   path when executing \code{uvr run}. Expects a string of paths separated by
#'   the standard OS path separator (\code{:} on Unix/macOS, \code{;} on Windows).
#'
#' @section UVR_INSTALL_DIR:
#'   Directory in which to install \code{uvr} using the standalone installer.
#'   Expects a valid absolute or relative directory path.
#'
#' @section UVR_INSTALL_TIMEOUT:
#'   Overrides the default per-package installation timeout (30 minutes).
#'   Expects a duration string such as \code{30m}, \code{2h}, \code{90s}, or a
#'   bare number representing seconds (e.g. \code{1800}).
#'
#' @section UVR_LIBRARY:
#'   Custom target directory for R package installations. Note: the CLI
#'   \code{--library} argument takes precedence over this variable. Defaults to
#'   the project-local \code{.uvr/library/} directory if neither are provided.
#'
#' @section UVR_PROGRESS:
#'   Controls the visibility of progress bars and spinners in the terminal.
#'   Acceptable values:
#'   \itemize{
#'     \item \code{always}, \code{1}, \code{true}: Forces progress to be drawn,
#'       bypassing TTY checks (useful for SSH).
#'     \item \code{never}, \code{0}, \code{false}: Forces progress to be hidden
#'       (useful for CI logs).
#'   }
#'   Defaults to automatically detecting a TTY.
#'
#' @section UVR_R_INSTALL_DIR:
#'   Directory where uvr-managed R versions are installed.
#'   Expects a valid absolute or relative directory path.
#'   Defaults to \code{~/.uvr/r-versions/} if not set.
#'
#' @name uvr-environment
#' @keywords internal
NULL
