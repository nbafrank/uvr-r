test_that("run_uvr works and errors on bad command", {
  path <- setup_uvr_test() # installs uvr if needed
  expect_no_error(run_uvr(args = c("r", "list"), bin = path))
  expect_error(run_uvr(args = "--nonexistent-flag", bin = path), "exited with code")
})
