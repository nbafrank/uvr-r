setup_uvr_test <- function() {
  path <- try(find_uvr())
  if (!nzchar(path)) {
    path <- install_uvr(tag = "latest", force = TRUE)
  }
  invisible(path)
}
