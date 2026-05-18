test_that("import works and create lockfile if desired", {
  skip("waiting on 0.3.5 release for https://github.com/nbafrank/uvr/issues/91")
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  example_renvlock <- system.file("extdata/renv.lock", package = "uvr")
  success <- file.copy(example_renvlock, temp_dir)

  expect_no_error(import(bin = path, dir = temp_dir, quiet = TRUE))
  expect_true(file.exists(file.path(temp_dir, "uvr.toml")))

  expect_snapshot(
    readLines(file.path(temp_dir, "uvr.toml")) |>
      paste(collapse = "\n") |>
      cat()
  )

  file.remove(file.path(temp_dir, "uvr.toml"))
  expect_no_error(
    import(do_lock = TRUE, bin = path, dir = temp_dir, quiet = TRUE)
  )
  expect_true(file.exists(file.path(temp_dir, "uvr.toml")))
  expect_true(file.exists(file.path(temp_dir, "uvr.lock")))
})
