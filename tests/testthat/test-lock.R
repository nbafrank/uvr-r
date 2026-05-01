test_that("lock works", {
  path <- setup_uvr_test() # installs uvr if needed
  temp_dir <- tempfile("uvr-test-")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)

  init(bin = path, dir = temp_dir)
  add("nbafrank/uvr-r@0.1.0", bin = path, dir = temp_dir)

  expect_no_error(lock(bin = path, dir = temp_dir))
  expect_true(file.exists(file.path(temp_dir, "uvr.lock")))

  # TODO: review this
  expect_snapshot(
    readLines(file.path(temp_dir, "uvr.lock")) |>
      paste(collapse = "\n") |>
      cat()
  )

  # TODO: test upgrade == TRUE
})
