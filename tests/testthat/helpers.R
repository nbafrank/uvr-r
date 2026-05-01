skip_if_no_uvr <- function() {
  candidate_path <- file.path(.get_home_dir(), ".cargo", "bin", "uvr")
  skip_if_not(
    nzchar(Sys.which("uvr")) || file.exists(candidate_path),
    message = "uvr binary not found"
  )
}
