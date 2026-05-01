test_that("run_uvr errors on bad command", {
  # Try installing if not found 
  path <- find_uvr()
  if (!file.exists(path)) {
    install_uvr()
  }
  expect_error(run_uvr("--nonexistent-flag"), "exited with code")
})
