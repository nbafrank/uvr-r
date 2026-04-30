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
#' @return Invisible path to the installed binary.
#' @export
#' @examples
#' \dontrun{
#' # Auto-detect best method
#' install_uvr()
#'
#' # Force rebuild from source
#' install_uvr(method = "cargo", force = TRUE)
#' }
install_uvr <- function(method = c("auto", "binary", "cargo"), force = FALSE) {
  method <- match.arg(method)

  if (!isTRUE(force)) {
    existing <- .find_uvr_path()
    if (!is.null(existing)) {
      message("uvr is already installed at: ", existing)
      message("Use `uvr::install_uvr(force = TRUE)` to reinstall.")
      return(invisible(existing))
    }
  }

  if (method == "auto" || method == "binary") {
    path <- .try_install_binary()
    if (!is.null(path)) {
      message("uvr installed successfully at: ", path)
      return(invisible(path))
    }
    if (method == "binary") {
      stop("No pre-built binary available for this platform.", call. = FALSE)
    }
  }

  # Fall back to cargo install
  .install_via_cargo()
}

#' Try to download a pre-built binary from GitHub releases
#' @return Path to binary or NULL if unavailable.
#' @keywords internal
.try_install_binary <- function() {
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    message("Package 'jsonlite' is needed to download pre-built binaries.")
    message("Install it with: install.packages('jsonlite')")
    return(NULL)
  }

  latest_release <- .get_latest_release_details()
  if (
    is.null(latest_release) ||
      is.null(latest_release$assets) ||
      nrow(latest_release$asset) == 0L
  ) {
    return(NULL)
  }
  download_url <- latest_release$asset$browser_download_url[1L]
  dest_dir <- file.path(.get_home_dir(), ".cargo", "bin")
  .get_and_extract_binary(download_url = download_url, dest_dir = dest_dir)
}

#' Install uvr via cargo
#' @return Invisible path to the installed binary.
#' @keywords internal
.install_via_cargo <- function() {
  cargo <- Sys.which("cargo")
  if (!nzchar(cargo)) {
    # Check common location
    cargo_candidate <- file.path(.get_home_dir(), ".cargo", "bin", "cargo")
    if (file.exists(cargo_candidate)) {
      cargo <- cargo_candidate
    } else {
      stop(
        "Neither uvr binary nor cargo found.\n",
        "Install Rust first: https://rustup.rs\n",
        "Then run: uvr::install_uvr(),",
        call. = FALSE
      )
    }
  }

  message("Building uvr from source via cargo (this may take a few minutes)...")
  return_code <- system2(
    command = cargo,
    args = c("install", "--git", "https://github.com/nbafrank/uvr"),
    stdout = "",
    stderr = ""
  )
  if (return_code != 0L) {
    stop("cargo install failed with exit code ", return_code, call. = FALSE)
  }

  path <- file.path(.get_home_dir(), ".cargo", "bin", .get_bin_name())
  if (!file.exists(path)) {
    stop(
      "cargo install succeeded but uvr binary not found at expected location.",
      call. = FALSE
    )
  }

  message("uvr installed successfully at: ", path)
  invisible(path)
}

#' Get details for the latest release of uvr from GitHub
#' @return List with release details or NULL if unavailable.
#' @keywords internal
.get_latest_release_details <- function() {
  os <- .Platform$OS.type
  arch <- Sys.info()[["machine"]]

  # Map to GitHub release asset names
  is_unix <- os == "unix"
  is_mac <- is_unix && Sys.info()[["sysname"]] == "Darwin"
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

  release_url <- "https://api.github.com/repos/nbafrank/uvr/releases/latest"
  con <- tryCatch(url(release_url), error = function(e) NULL)
  if (is.null(con)) {
    return(NULL)
  }
  on.exit(close(con), add = TRUE)

  latest_release <- tryCatch(
    jsonlite::fromJSON(readLines(con, warn = FALSE)),
    error = function(e) NULL
  )

  is_target <- grepl(target, latest_release$assets$name, fixed = TRUE)
  latest_release$asset <- latest_release$assets[is_target, ]

  return(latest_release)
}

#' Download and extract uvr binary
#' @return Destination path or NULL if download failed.
#' @keywords internal
.get_and_extract_binary <- function(download_url, dest_dir) {
  is_windows <- .Platform$OS.type == "windows"
  dir.create(dest_dir, recursive = TRUE, showWarnings = FALSE)
  dest <- file.path(dest_dir, .get_bin_name())

  message("Downloading uvr from: ", download_url)
  tmp <- tempfile(fileext = tools::file_ext(download_url))
  ok <- tryCatch(
    {
      utils::download.file(download_url, tmp, mode = "wb", quiet = TRUE)
      TRUE
    },
    error = function(e) {
      message("Download failed: ", conditionMessage(e))
      FALSE
    }
  )
  if (!ok) {
    return(NULL)
  }

  is_tarball <- grepl("\\.tar\\.gz$", tmp)
  is_zip <- grepl("\\.zip$", tmp)

  if (is_tarball || is_zip) {
    exdir <- tempfile("uvr-extract-")
    dir.create(exdir)
    on.exit(unlink(exdir, recursive = TRUE), add = TRUE)

    if (is_tarball) {
      utils::untar(tmp, exdir = exdir)
    } else {
      utils::unzip(tmp, exdir = exdir)
    }
    if (is.na(bin)) {
      return(NULL)
    }
    file.copy(bin, dest, overwrite = TRUE)
  } else {
    file.copy(tmp, dest, overwrite = TRUE)
  }
  if (!is_windows) {
    Sys.chmod(dest, "0755")
  }
  dest
}
