test_that("r_install works", {
  # TODO: write without side effects
})

test_that("r_list works and all = TRUE returns at least 1 version", {
  path <- setup_uvr_test() # installs uvr if needed
  expect_no_error(r_list(bin = path))
  all_versions <- expect_no_error(r_list(all = TRUE, bin = path))
  expect_true(length(all_versions) > 0L)
})

test_that("r_use works", {
  path <- setup_uvr_test() # installs uvr if needed
  temp_dir <- tempfile("uvr-test-")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  init(bin = path, dir = temp_dir)

  expect_no_error(r_use(">= 4.0.0", bin = path, dir = temp_dir))

  version_entry <- readLines(file.path(temp_dir, "uvr.toml")) |>
    grep(pattern = "^r_version =", value = TRUE) # TODO: confirm correct pattern
  expect_true(length(version_entry) == 1L)
  expect_true(grepl(pattern = ">= 4.0.0", x = version_entry))
})

test_that("r_pin works", {
  path <- setup_uvr_test() # installs uvr if needed
  temp_dir <- tempfile("uvr-test-")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  init(bin = path, dir = temp_dir)

  expect_no_error(r_pin("4.0.0", bin = path, dir = temp_dir))
  expect_true(file.exists(file.path(temp_dir, ".r-version")))
  expect_identical(readLines(file.path(temp_dir, ".r-version")), "4.0.0")

  # TODO: confirm entry in .toml created as well?
  version_entry <- readLines(file.path(temp_dir, "uvr.toml")) |>
    grep(pattern = "^r_version =", value = TRUE) # TODO: confirm correct pattern
  expect_true(length(version_entry) == 1L)
  expect_true(grepl(pattern = "4.0.0", x = version_entry))
})
