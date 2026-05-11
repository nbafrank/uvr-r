setup_uvr_test <- function(temp_dir = NULL, force = FALSE) {
  path <- try(find_uvr())
  if (!nzchar(path)) {
    path <- install_uvr(tag = "latest", install_dir = temp_dir, force = force)
  }
  invisible(path)
}
