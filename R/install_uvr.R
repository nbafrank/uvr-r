#' Install the uvr binary
#'
#' Downloads and installs the \code{uvr} binary. By default, tries to download
#' a pre-built binary from GitHub releases. If not available for the
#' current platform, falls back to building from source via \code{cargo install}
#' (requires the Rust toolchain).
#'
#' @param method Installation method: \code{"auto"} (default) tries a pre-built
#' GitHub release binary first, then falls back to building from source via
#' \code{cargo install}. \code{"binary"} downloads a pre-built binary only.
#' \code{"cargo"} builds from source only.
#' @param force If \code{TRUE}, reinstall even if uvr is already present.
#' @param timeout Download timeout in seconds (default 60, matching
#'   \code{utils::download.file()}). Increase on slow connections, e.g.
#'   \code{install_uvr(timeout = 300)}. The R session's \code{timeout} option
#'   is restored on exit.
#' @inheritParams .get_release_details
#' @inheritParams .try_install_binary
#'
#' @return Invisible path to the installed binary.
#' @export
#' @family uvr setup functions
#' @examples
#' \dontrun{
#' # Auto-detect best method
#' install_uvr()
#'
#' # Force rebuild from source
#' install_uvr(method = "cargo", force = TRUE)
#'
#' # Slow connection: allow the download 5 minutes
#' install_uvr(timeout = 300)
#'
#' # Install a specific earlier release
#' install_uvr(tag = "v0.4.1", force = TRUE)
#' }
install_uvr <- function(
  tag = "latest",
  method = c("auto", "binary", "cargo"),
  install_dir = NULL,
  force = FALSE,
  timeout = 60
) {
  method <- match.arg(method)
  .validate_single_characters(list(tag = tag))
  .validate_single_characters(list(install_dir = install_dir), null_ok = TRUE)
  .validate_flags(list(force = force))
  .validate_positive_numbers(list(timeout = timeout))
  install_dir <- install_dir %||% .get_home_dir # NULL swap

  if (!isTRUE(force)) {
    existing <- .find_uvr_path(install_dir = install_dir, check_path = FALSE)
    if (!is.null(existing)) {
      message("uvr is already installed at: ", existing)
      message("Use `uvr::install_uvr(force = TRUE)` to reinstall.")
      return(invisible(existing))
    }
  }

  if (method == "auto" || method == "binary") {
    path <- .try_install_binary(
      tag = tag,
      install_dir = install_dir,
      timeout = timeout
    )
    if (!is.null(path)) {
      message("uvr installed successfully at: ", path)
      return(invisible(path))
    }
    if (method == "binary") {
      stop("No pre-built binary available for this platform.", call. = FALSE)
    }
  }

  # Fall back to cargo install
  .install_via_cargo(tag = tag, install_dir = install_dir, force = force)
}

#' Try to download a pre-built binary from GitHub releases
#' @param install_dir Directory to install into (default: home directory).
#' @inheritParams install_uvr
#' @inheritParams .get_release_details
#' @return Path to binary or NULL if unavailable.
#' @keywords internal
.try_install_binary <- function(
  tag = "latest",
  install_dir = .get_home_dir(),
  timeout = 60
) {
  .validate_single_characters(list(tag = tag))

  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    message("Package 'jsonlite' is needed to download pre-built binaries.")
    message("Install it with: install.packages('jsonlite')")
    return(NULL)
  }

  release <- .get_release_details(tag = tag)
  if (
    is.null(release) || is.null(release$assets) || nrow(release$asset) == 0L
  ) {
    return(NULL)
  }
  download_url <- release$asset$browser_download_url[1L]
  dest_dir <- file.path(install_dir, ".cargo", "bin")
  .get_and_extract_binary(
    download_url = download_url,
    dest_dir = dest_dir,
    timeout = timeout
  )
}

#' Install uvr via cargo
#' @inheritParams .get_release_details
#' @inheritParams .try_install_binary
#' @return Invisible path to the installed binary.
#' @keywords internal
.install_via_cargo <- function(
  tag = "latest",
  install_dir = .get_home_dir(),
  force = FALSE
) {
  cargo <- Sys.which("cargo")
  if (!nzchar(cargo)) {
    cargo <- file.path(install_dir, ".cargo", "bin", .get_bin_name("cargo"))
    if (!file.exists(cargo)) {
      stop(
        "Neither uvr binary nor cargo found.\n",
        "Install Rust first: https://rustup.rs\n",
        "Then run: uvr::install_uvr(),",
        call. = FALSE
      )
    }
  }

  message("Building uvr from source via cargo (this may take a few minutes)...")
  args <- c("install", "--git", "https://github.com/nbafrank/uvr")
  if (!is.null(tag)) {
    if (tag == "latest") {
      details <- .get_release_details(tag = tag)
      tag <- details$tag_name
    }
    args <- c(args, "--tag", tag)
  }
  if (isTRUE(force)) {
    args <- c(args, "--force")
  }
  return_code <- .run_cargo(command = cargo, args = args)
  if (return_code != 0L) {
    stop("cargo install failed with exit code ", return_code, call. = FALSE)
  }

  path <- file.path(install_dir, ".cargo", "bin", .get_bin_name())
  if (!file.exists(path)) {
    stop(
      "cargo install succeeded but uvr binary not found at expected location.",
      call. = FALSE
    )
  }

  message("uvr installed successfully at: ", path)
  invisible(path)
}

#' Invoke cargo (thin wrapper over system2, mockable in tests)
#' @keywords internal
.run_cargo <- function(command, args) {
  system2(command = command, args = args, stdout = "", stderr = "")
}

#' Get details for a specified release of uvr from GitHub
#' @param tag Release tag, e.g. "v1.0.0". Defaults to latest release.
#' @return List with release details or NULL if unavailable.
#' @keywords internal
.get_release_details <- function(tag = "latest") {
  os <- .Platform$OS.type
  arch <- Sys.info()[["machine"]]
  sysname <- Sys.info()[["sysname"]]

  # Map to GitHub release asset names
  is_unix <- os == "unix"
  is_mac <- is_unix && sysname == "Darwin"
  is_windows <- os == "windows"
  if (is_mac) {
    target <- ifelse(
      arch %in% c("arm64", "aarch64"),
      "aarch64-apple-darwin",
      "x86_64-apple-darwin"
    )
  } else if (is_unix) {
    target <- ifelse(
      arch %in% c("aarch64", "arm64"),
      "aarch64-unknown-linux-gnu",
      "x86_64-unknown-linux-gnu"
    )
  } else if (is_windows) {
    target <- "x86_64-pc-windows-msvc"
  } else {
    warning("Unknown OS derived from `Sys.info()`: ", os)
    return(NULL)
  }

  release_url <- "https://api.github.com/repos/nbafrank/uvr/releases/"
  if (tag != "latest") {
    release_url <- paste0(release_url, "tags/")
  }
  release_url <- paste0(release_url, tag)
  con <- tryCatch(
    url(
      release_url,
      headers = if (
        !is.null(Sys.getenv("GITHUB_PAT")) && Sys.getenv("GITHUB_PAT") != ""
      ) {
        c(Authorization = paste("Bearer", Sys.getenv("GITHUB_PAT")))
      }
    ),
    error = function(e) NULL
  )
  if (is.null(con)) {
    return(NULL)
  }
  on.exit(close(con), add = TRUE)

  release <- tryCatch(
    jsonlite::fromJSON(readLines(con, warn = FALSE)),
    error = function(e) NULL
  )

  is_target <- grepl(target, release$assets$name, fixed = TRUE)
  release$asset <- release$assets[is_target, ]

  return(release)
}

#' Download a file (thin wrapper over utils::download.file, mockable in tests)
#' @keywords internal
.download_file <- function(url, destfile) {
  utils::download.file(url, destfile, mode = "wb", quiet = TRUE)
}

#' Download and extract uvr binary
#' @inheritParams install_uvr
#' @return Destination path or NULL if download failed. A download that hits
#'   the timeout errors instead of returning NULL, so the caller does not
#'   fall through to the misleading "no pre-built binary" path.
#' @keywords internal
.get_and_extract_binary <- function(download_url, dest_dir, timeout = 60) {
  dir.create(dest_dir, recursive = TRUE, showWarnings = FALSE)
  bin_name <- .get_bin_name()
  dest <- file.path(dest_dir, bin_name)

  # Scope the download timeout to this call; restore whatever the user had.
  old_timeout <- options(timeout = timeout)
  on.exit(options(old_timeout), add = TRUE)

  message("Downloading uvr from: ", download_url)
  tmp <- tempfile(fileext = tools::file_ext(download_url))
  # download.file() reports a timeout as warnings followed by a generic
  # error, so collect the warnings to tell "timed out" apart from
  # "unavailable" and give each its own message.
  warnings_seen <- character(0)
  ok <- tryCatch(
    {
      withCallingHandlers(
        .download_file(download_url, tmp),
        warning = function(w) {
          warnings_seen <<- c(warnings_seen, conditionMessage(w))
          invokeRestart("muffleWarning")
        }
      )
      TRUE
    },
    error = function(e) {
      all_msgs <- c(conditionMessage(e), warnings_seen)
      if (any(grepl("timeout", all_msgs, ignore.case = TRUE))) {
        stop(
          "Download of the uvr binary timed out after ",
          timeout,
          " seconds.\n",
          "On a slow connection, allow more time with e.g.:\n",
          "  uvr::install_uvr(timeout = 300, force = TRUE)",
          call. = FALSE
        )
      }
      message("Download failed: ", conditionMessage(e))
      FALSE
    }
  )
  if (!ok) {
    return(NULL)
  }

  # Decide by the URL, not the tempfile: tempfile(fileext =
  # tools::file_ext(url)) yields a name ending in plain "gz"/"zip" (no dot,
  # and never ".tar.gz"), so matching on `tmp` classified every archive as
  # a bare binary and installed the compressed blob as "uvr".
  is_tarball <- grepl("\\.tar\\.gz$", download_url)
  is_zip <- grepl("\\.zip$", download_url)

  if (is_tarball || is_zip) {
    exdir <- .make_temp_dir("uvr-extract")
    if (is_tarball) {
      utils::untar(tmp, exdir = exdir)
    } else {
      utils::unzip(tmp, exdir = exdir)
    }

    bin <- list.files(
      exdir,
      pattern = paste0("^", bin_name, "$"),
      recursive = TRUE,
      full.names = TRUE
    )[1L]
    if (is.na(bin)) {
      return(NULL)
    }
    file.copy(bin, dest, overwrite = TRUE)
  } else {
    file.copy(tmp, dest, overwrite = TRUE)
  }
  if (.Platform$OS.type != "windows") {
    Sys.chmod(dest, "0755")
  }
  dest
}
