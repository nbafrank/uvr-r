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

test_that(".temp_setenv works and cleans up properly", {
  # Case: NULLs ignored
  expect_true(Sys.getenv("foo") == "")
  setter <- \() {
    .temp_setenv(list(foo = NULL))
    expect_true(Sys.getenv("foo") == "")
  }
  expect_no_error(setter())
  expect_true(Sys.getenv("foo") == "")

  # Case: single value gets set/unset right
  expect_true(Sys.getenv("foo") == "")
  setter <- \() {
    .temp_setenv(list(foo = "bar"))
    expect_true(Sys.getenv("foo") == "bar")
  }
  expect_no_error(setter())
  expect_true(Sys.getenv("foo") == "")

  # Case: multiple values get set/unset right
  expect_true(Sys.getenv("foo1") == "" && Sys.getenv("foo2") == "")
  setter <- \() {
    .temp_setenv(list(foo1 = "bar1", foo2 = "bar2"))
    expect_true(Sys.getenv("foo1") == "bar1" && Sys.getenv("foo2") == "bar2")
  }
  expect_no_error(setter())
  expect_true(Sys.getenv("foo1") == "" && Sys.getenv("foo2") == "")

  # Case: existing env vars respected
  expect_true(Sys.getenv("foo") == "")
  Sys.setenv(foo = "bar")
  setter <- \() {
    .temp_setenv(list(foo = "bar2"))
    expect_true(Sys.getenv("foo") == "bar2")
  }
  expect_no_error(setter())
  expect_true(Sys.getenv("foo") == "bar")
})
