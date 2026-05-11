test_that("import works and create lockfile if desired", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  example_renvlock <- system.file("extdata/renv.lock", package = "uvr")
  success <- file.copy(example_renvlock, temp_dir)

  expect_no_error(import(bin = path, dir = temp_dir))
  expect_true(file.exists(file.path(temp_dir, "uvr.toml")))

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
