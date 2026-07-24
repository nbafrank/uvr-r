test_that("import works and create lockfile if desired", {
  skip_on_cran()
  skip_if_offline()
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  example_renvlock <- system.file("extdata/renv.lock", package = "uvr")
  success <- file.copy(example_renvlock, temp_dir)
  # import --lock installs packages, so the project must target this
  # session's R (see pin_session_r)
  pin_session_r(temp_dir)

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
