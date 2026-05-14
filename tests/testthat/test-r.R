test_that("r_install works", {
  skip("has side effects - need arg added to uvr r install (see #89)")
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  expect_no_error(
    r_install(version = "4.0.0", bin = path, dir = temp_dir, quiet = TRUE)
  )
})

test_that("r_list works and all = TRUE returns at least 1 version", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  expect_no_error(r_list(bin = path, quiet = TRUE))
  all_versions <- expect_no_error(r_list(all = TRUE, bin = path, quiet = TRUE))
  expect_true(length(all_versions[-1]) > 0L)
})

test_that("r_use works", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE) # installs uvr if needed

  expect_no_error(
    r_use(version = ">=4.0.0", bin = path, dir = temp_dir, quiet = TRUE)
  )

  version_entry <- readLines(file.path(temp_dir, "uvr.toml")) |>
    grep(pattern = "^r_version =", value = TRUE)
  expect_true(length(version_entry) == 1L)
  expect_true(grepl(pattern = ">=4.0.0", x = version_entry))
})

test_that("r_pin works", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE) # installs uvr if needed

  expect_no_error(r_pin("4.0.0", bin = path, dir = temp_dir, quiet = TRUE))
  expect_true(file.exists(file.path(temp_dir, ".r-version")))
  expect_identical(readLines(file.path(temp_dir, ".r-version")), "4.0.0")
})
