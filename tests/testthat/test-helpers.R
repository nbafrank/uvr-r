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

test_that(".get_home_dir works", {
  home <- expect_no_error(.get_home_dir())
  expect_type(home, "character")
  expect_true(length(home) == 1L)
  expect_true(dir.exists(home))
})
