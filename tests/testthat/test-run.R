test_that("run works and requires script argument", {
  skip("wait for 0.3.5 release for https://github.com/nbafrank/uvr/issues/81")
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  file.copy(system.file("extdata/test.R", package = "uvr"), temp_dir)
  expect_no_error(
    run(script = "test.R", bin = path, dir = temp_dir, quiet = TRUE)
  ) |>
    paste(collapse = "\n") |>
    cat() |>
    expect_snapshot()

  expect_error(run(quiet = TRUE), "missing")
})
