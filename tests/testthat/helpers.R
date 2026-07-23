# Pin a test project to the R version running the tests. uvr (>= 0.4.x)
# refuses to install into a project whose lockfile resolves to a different
# R than the session it is invoked from — correct in real use, fatal in
# tests, where uvr would otherwise resolve for the newest R it can find.
pin_session_r <- function(dir) {
  writeLines(
    paste(R.version$major, R.version$minor, sep = "."),
    file.path(dir, ".r-version")
  )
}

# Read the locked version of `pkg` from a project's uvr.lock, or NA if the
# package is not in the lockfile.
locked_version <- function(dir, pkg) {
  lock_path <- file.path(dir, "uvr.lock")
  if (!file.exists(lock_path)) {
    return(NA_character_)
  }
  lines <- readLines(lock_path)
  name_idx <- grep(sprintf('^name = "%s"$', pkg), lines)
  if (length(name_idx) == 0L) {
    return(NA_character_)
  }
  # version is within the same [[package]] block, shortly after the name
  block <- lines[name_idx[1L]:min(name_idx[1L] + 5L, length(lines))]
  version_line <- grep('^version = "', block, value = TRUE)
  if (length(version_line) == 0L) {
    return(NA_character_)
  }
  sub('^version = "([^"]+)"$', "\\1", version_line[1L])
}

setup_uvr_test <- function(
  temp_dir,
  check_existing = TRUE,
  init = FALSE,
  add = FALSE
) {
  path <- if (check_existing) {
    try(find_uvr())
  } else {
    FALSE
  }
  if (!check_existing || !nzchar(path)) {
    testthat::skip_on_cran()
    testthat::skip_if_offline()
    path <- install_uvr(tag = "latest", install_dir = temp_dir)
  }
  if (isTRUE(init)) {
    init(bin = path, dir = temp_dir, quiet = TRUE)
    pin_session_r(temp_dir)
  }
  if (isTRUE(add)) {
    if (isFALSE(init)) {
      warning("add = TRUE requires init = TRUE - skipping add()")
    } else {
      add(
        "jsonlite",
        do_install = FALSE,
        bin = path,
        dir = temp_dir,
        quiet = TRUE
      )
    }
  }
  invisible(path)
}
