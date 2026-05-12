setup_uvr_test <- function(temp_dir = NULL, force = FALSE) {
  path <- try(find_uvr())
  if (!nzchar(path)) {
    path <- install_uvr(tag = "latest", install_dir = temp_dir, force = force)
  }
  invisible(path)
}

.make_temp_dir <- function(name = "uvr-test") {
  temp_dir <- dirname(tempfile()) |> file.path(name)
  dir.create(temp_dir, recursive = TRUE)
  return(temp_dir)
}
