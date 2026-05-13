test_that("lock works", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  init(bin = path, dir = temp_dir, quiet = TRUE)
  add("jsonlite@2.0.0", bin = path, dir = temp_dir, quiet = TRUE)

  expect_no_error(lock(bin = path, dir = temp_dir, quiet = TRUE))
  expect_true(file.exists(file.path(temp_dir, "uvr.lock")))

  expect_snapshot(
    readLines(file.path(temp_dir, "uvr.lock")) |>
      paste(collapse = "\n") |>
      cat()
  )
  # TODO: test upgrade == TRUE
})
