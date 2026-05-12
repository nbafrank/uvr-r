setup_uvr_test <- function(temp_dir = NULL, check_existing = TRUE) {
  path <- if (check_existing) {
    try(find_uvr())
  }else {
    FALSE
  }
  if (!check_existing || !nzchar(path)) {
    testthat::skip_on_cran()
    testthat::skip_if_offline()
    path <- install_uvr(tag = "latest", install_dir = temp_dir)
  }
  invisible(path)
}

.make_temp_dir <- function(name = "uvr-test") {
  temp_dir <- dirname(tempfile()) |> file.path(name)
  dir.create(temp_dir, recursive = TRUE)
  return(temp_dir)
}
