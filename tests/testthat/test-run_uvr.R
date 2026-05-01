test_that("run_uvr errors on bad command", {
  path <- setup_uvr_test() # installs uvr if needed
  expect_error(run_uvr(args = "--nonexistent-flag", bin = path), "exited with code")
})
