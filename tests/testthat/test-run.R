test_that("run works and requires script argument", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  file.copy(system.file("extdata/test.R", package = "uvr"), temp_dir)
  output <- run(script = "test.R", bin = path, dir = temp_dir, quiet = TRUE)
  # The script's output comes back through uvr run; the exact R banner is
  # machine-dependent, so assert on the script's own output only.
  expect_true(any(grepl("Hello World", output, fixed = TRUE)))

  expect_error(run(quiet = TRUE), "missing")
})
