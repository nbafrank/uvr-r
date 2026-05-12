test_that("run_uvr works and errors on bad command", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  # Case: success
  result <- expect_no_error(run_uvr(args = c("r", "list"), bin = path)) |>
    expect_output()
  expect_true(length(result) > 0L && is.character(result))

  # Case: success, but quiet
  result2 <- expect_no_error(run_uvr(
    args = c("r", "list"),
    bin = path,
    quiet = TRUE
  )) |>
    expect_silent()
  expect_identical(result, result2)

  # Case: bad command
  result <- expect_error(
    run_uvr(args = "--nonexistent-flag", bin = path) |> expect_output(),
    "exited with code"
  )
  expect_s3_class(result, "simpleError")

  # Case: bad command, but quiet
  result2 <- expect_error(
    run_uvr(args = "--nonexistent-flag", bin = path, quiet = TRUE),
    "exited with code"
  )
  expect_identical(
    result[names(result) != "trace"],
    result2[names(result) != "trace"]
  )
})
