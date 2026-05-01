test_that("import works and create lockfile if desired", {
  path <- setup_uvr_test() # installs uvr if needed
  temp_dir <- tempfile("uvr-test-")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)

  example_renvlock <- system.file("extdata/renv.lock", package = "uvr")
  file.copy(example_renvlock, temp_dir)

  expect_no_error(import(bin = path, dir = temp_dir))
  expect_true(file.exists(file.path(temp_dir, "uvr.toml")))

  # TODO: review this
  expect_snapshot(
    readLines(file.path(temp_dir, "uvr.toml")) |>
      paste(collapse = "\n") |>
      cat()
  )

  file.remove(file.path(temp_dir, "uvr.toml"))
  expect_no_error(import(lock = TRUE, bin = path, dir = temp_dir))
  expect_true(file.exists(file.path(temp_dir, "uvr.toml")))
  expect_true(file.exists(file.path(temp_dir, "uvr.lock")))
})
