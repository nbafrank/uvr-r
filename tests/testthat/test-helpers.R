test_that(".get_bin_name works", {
  expect_no_error(.get_bin_name())
  expect_type(.get_bin_name(), "character")
  expect_true(length(.get_bin_name()) == 1L)
  expect_true(.get_bin_name() %in% c("uvr", "uvr.exe"))
})

test_that(".get_bin_name handles windows .exe suffix", {
  expect_equal(.get_bin_name(os_type = "unix"), "uvr")
  expect_equal(.get_bin_name(os_type = "windows"), "uvr.exe")
})

test_that(".get_bin_name handles bins other than `uvr`", {
  expect_equal(.get_bin_name("cargo", os_type = "unix"), "cargo")
  expect_equal(.get_bin_name("cargo", os_type = "windows"), "cargo.exe")
})

test_that(".get_home_dir works", {
  home <- expect_no_error(.get_home_dir())
  expect_type(home, "character")
  expect_true(length(home) == 1L)
  expect_true(dir.exists(home))
})

test_that(".get_uvr_version works", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  version <- expect_no_error(.get_uvr_version(bin = path))
  expect_type(version, "character")
  expect_length(version, 1L)
  expect_no_error(package_version(version))
})

test_that(".get_uvr_min_version works", {
  min_version <- expect_no_error(.get_uvr_min_version())
  expect_type(min_version, "character")
  expect_length(min_version, 1L)
  expect_no_error(package_version(min_version))
})

test_that(".check_uvr_version works", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  # Case: newest version should be installed - so no error
  expect_no_error(.check_uvr_version(bin = path))

  # Case: old version should throw error
  with_mocked_bindings(
    .get_uvr_version = \(...) "0.0.0",
    expect_error(
      .check_uvr_version(bin = path),
      "uvr binary version 0.0.0 is too old."
    )
  )
})

test_that(".get_uvr_version() handles missing binary gracefully", {
  # Test when binary doesn't exist or can't be executed
  fake_bin <- file.path(tempdir(), "nonexistent_uvr_binary.exe")

  # The current buggy implementation returns FALSE, which causes issues
  # when passed to package_version()
  expect_error(
    .get_uvr_version(bin = fake_bin),
    regexp = "Could not determine uvr binary version"
  )
})

test_that(".get_uvr_version() returns valid version string", {
  temp_dir <- .make_temp_dir()
  bin <- setup_uvr_test(temp_dir = temp_dir)

  version <- .get_uvr_version(bin = bin)

  # Should be a character string parseable as a version
  expect_type(version, "character")
  expect_length(version, 1)
  expect_no_error(package_version(version))
})

test_that(".check_uvr_version() handles binary is missing", {
  expect_error(
    .check_uvr_version(bin = file.path(tempdir(), "fake_uvr")),
    regexp = "Could not determine uvr binary version",
    class = "error"
  )
})
