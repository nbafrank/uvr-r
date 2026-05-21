#' Get the name of a binary for Unix or Windows (+".exe")
#' @param name Name of binary to return OS-specific name for (default: "uvr")
#' @param os_type OS type, defaults to \code{.Platform$OS.type}.
#' @return OS-specific name of the binary (i.e. "uvr" or "uvr.exe").
#' @keywords internal
.get_bin_name <- function(name = "uvr", os_type = .Platform$OS.type) {
  paste0(name, if (os_type == "windows") ".exe" else "")
}

#' Return HOME/USER directory
#'
#' Internal helper that returns the user's home directory.
#' (Windows: \code{USERPROFILE}, Unix: \code{HOME})
#'
#' @return Path to user's home directory.
#' @keywords internal
.get_home_dir <- function() {
  if (.Platform$OS.type == "windows") {
    home <- Sys.getenv("USERPROFILE")
  } else {
    home <- Sys.getenv("HOME")
  }

  if (!nzchar(home)) {
    home <- path.expand("~")
  }

  return(home)
}

#' Swap out NULL values with another value
#' @return y if x is NULL, otherwise x
#' @name op-null-swap
#' @keywords internal
`%||%` <- function(x, y) {
  if (is.null(x)) {
    if (is.function(y)) y() else y
  } else {
    x
  }
}

#' Run a terminal command and capture the output cleanly
#' @param bin Path to the binary to run
#' @param args Arguments to pass to the binary
#' @param quiet If \code{TRUE}, suppress output from the binary
#' @return A list with elements \code{stdout}, \code{stderr}, and \code{return_code}, captured from the process.
#' @keywords internal
.run_and_capture <- function(bin, args, quiet = FALSE) {
  proc <- processx::process$new(
    bin,
    args,
    stdout = "|", # pipe so we can read programmatically
    stderr = "|"
  )

  stdout_lines <- character(0)
  stderr_lines <- character(0)

  # Poll while process is alive
  while (proc$is_alive()) {
    # Read whatever is available right now (non-blocking)
    out <- proc$read_output_lines()
    err <- proc$read_error_lines()

    if (length(out)) {
      stdout_lines <- c(stdout_lines, out)
      if (!quiet) cat(out, sep = "\n")
    }
    if (length(err)) {
      stderr_lines <- c(stderr_lines, err)
      if (!quiet) {
        cat(paste(err, collapse = "\n"), "\n", file = stderr(), sep = "")
      }
    }
  }

  # Drain any remaining output after process exits
  out <- proc$read_output_lines()
  err <- proc$read_error_lines()
  if (length(out)) {
    stdout_lines <- c(stdout_lines, out)
    if (!quiet) cat(out, sep = "\n")
  }
  if (length(err)) {
    stderr_lines <- c(stderr_lines, err)
    if (!quiet) message(paste(err, collapse = "\n"))
  }

  list(
    stdout = stdout_lines,
    stderr = stderr_lines,
    return_code = proc$get_exit_status()
  )
}

#' Create a temporary directory and cleanup this calls parent environment closes
#' @keywords internal
.make_temp_dir <- function(name = "uvr-test", envir = parent.frame()) {
  temp_dir <- dirname(tempfile()) |> file.path(name)
  dir.create(temp_dir, recursive = TRUE)
  withr::defer(
    {
      unlink(temp_dir, recursive = TRUE)
    },
    envir = envir
  )
  return(temp_dir)
}

#' Set up cache directory environment variable
#'
#' @details creates a side effect of setting the
#'   \code{UVR_CACHE_DIR} environment variable,
#'   then unsetting it when parent function closes
#' @param cache_dir User-provided cache directory or NULL
#' @return NULL (side effects only)
#' @keywords internal
.setup_cache_dir <- function(cache_dir, envir = parent.frame()) {
  env_cache_dir <- Sys.getenv("UVR_CACHE_DIR")

  if (env_cache_dir == "") {
    cache_dir <- cache_dir %||% "~/.uvr/cache/"
  }

  if (cache_dir != "~/.uvr/cache/") {
    Sys.setenv(UVR_CACHE_DIR = cache_dir)
    withr::defer(
      Sys.setenv(UVR_CACHE_DIR = env_cache_dir),
      envir = envir
    )
  }

  invisible(NULL)
}

#' Validate logical flag(s)
#' @param flags Named list of logical flags
#' @keywords internal
.validate_flags <- function(flags) {
  for (flag in names(flags)) {
    value <- flags[[flag]]
    is_single_logical <- isTRUE(value) || isFALSE(value)
    if (!is_single_logical) {
      stop(paste0("Argument `", flag, "` must be single logical value."))
    }
  }
}

#' Validate single character value(s)
#' @param character_flags Named list of values to validate
#' @keywords internal
.validate_single_characters <- function(character_flags, null_ok = FALSE) {
  for (flag in names(character_flags)) {
    value <- character_flags[[flag]]
    is_single_char <- is.character(value) &&
      !anyNA(value) &&
      length(value) == 1L
    if (null_ok) {
      if (!is.null(value) && !is_single_char) {
        stop(paste0(
          "Argument `",
          flag,
          "` must be NULL or a single non-NA character value."
        ))
      }
    } else {
      if (!is_single_char) {
        stop(paste0(
          "Argument `",
          flag,
          "` must be a single non-NA character value."
        ))
      }
    }
  }
}

#' Validate multiple (more than 0) character value(s)
#' @param character_flags Named list of values to validate
#' @keywords internal
.validate_multi_characters <- function(character_flags, null_ok = FALSE) {
  for (flag in names(character_flags)) {
    values <- character_flags[[flag]]
    is_multi_char <- is.character(values) &&
      !anyNA(values) &&
      length(values) >= 1L
    if (null_ok) {
      if (!is.null(values) && !is_multi_char) {
        stop(paste0(
          "Argument `",
          flag,
          "` must be NULL or a non-NA character vector with length > 0."
        ))
      }
    } else {
      if (!is_multi_char) {
        stop(paste0(
          "Argument `",
          flag,
          "` must be a non-NA character vector with length > 0."
        ))
      }
    }
  }
}

.validate_versions <- function(versions, null_ok = FALSE) {
  .validate_single_characters(versions, null_ok = null_ok)
  sapply(versions, package_version)
  invisible(TRUE)
}

#' Check that uvr binary version is recent enough
#' @inheritParams run_uvr
#' @details
#'   Checks the SystemRequirements field of the package description
#'   to ensure that the uvr binary is recent enough.
#' @keywords internal
.check_uvr_version <- function(bin = NULL) {
  .validate_single_characters(list(bin = bin), null_ok = TRUE)

  version <- .get_uvr_version(bin = bin)
  min_version <- .get_uvr_min_version()
  if (package_version(version) < package_version(min_version)) {
    msg <- sprintf(
      paste0(
        "uvr binary version %s is too old.",
        " Minimum required version is %s.",
        "\nRun `uvr::install_uvr(force = TRUE)` to update."
      ),
      version,
      min_version
    )
    stop(msg, call. = FALSE)
  }
  invisible(TRUE)
}

#' Get uvr binary version
#' @inheritParams run_uvr
#' @return character value of uvr binary version (i.e. "1.0.0")
#' @keywords internal
.get_uvr_version <- function(bin = NULL) {
  .validate_single_characters(list(bin = bin), null_ok = TRUE)
  bin <- bin %||% find_uvr # NULL swap
  version_output <- tryCatch(
    system2(bin, "--version", stdout = TRUE, stderr = TRUE),
    error = function(e) NULL
  )
  if (is.null(version_output)) {
    stop("Could not determine uvr binary version")
  }
  version <- sub(
    pattern = "uvr\\s+",
    replacement = "",
    x = version_output
  )
  .validate_versions(list(version = version))
  version
}

#' Get minimum uvr binary version declared in package description
#' @return character value of minimum uvr binary version (i.e. "1.0.0")
#' @keywords internal
.get_uvr_min_version <- function() {
  description_entry <- utils::packageDescription("uvr")$SystemRequirements

  # should only come up in development
  if (is.null(description_entry)) {
    stop(
      "Could not determine minimum uvr binary version.",
      " Ensure `SystemRequirements: uvr (>= x.x.x)` field in package description.",
      call. = FALSE
    )
  }

  min_version <- sub(
    pattern = ".*uvr \\(>= ([^)]+)\\).*",
    replacement = "\\1",
    x = description_entry
  )
  success <- tryCatch(
    .validate_versions(list(min_version = min_version)),
    error = \(...) FALSE
  )
  if (!success) {
    stop(
      "Could not determine minimum uvr binary version.",
      " Ensure `SystemRequirements: uvr (>= x.x.x)` field properly formatted in package description.",
      sprintf("\nCurrent entry: `%s`", description_entry),
      call. = FALSE
    )
  }
  min_version
}
