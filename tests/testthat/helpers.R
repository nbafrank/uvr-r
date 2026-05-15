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
  }
  if (isTRUE(add)) {
    if (isFALSE(init)) {
      warning("add = TRUE requires init = TRUE - skipping add()")
    } else {
      skip(
        "waiting on 0.3.5 release of uvr with relevant fixes (--no-lock flag)"
      )
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
