test_that("run_uvr errors on bad command", {
  skip_if_no_uvr()
  expect_error(run_uvr("--nonexistent-flag"), "exited with code")
})
