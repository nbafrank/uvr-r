test_that("run_uvr works and errors on bad command", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  expect_no_error(run_uvr(args = c("r", "list"), bin = path))
  expect_error(
    run_uvr(args = "--nonexistent-flag", bin = path),
    "exited with code"
  )
})
