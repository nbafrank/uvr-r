# Env-var scoping (#15): each helper sets during the calling function and
# restores the previous state — set or unset — afterwards.

test_that(".setup_env_var sets within scope and unsets after", {
  Sys.unsetenv("UVR_TEST_VAR")

  local({
    .setup_env_var("UVR_TEST_VAR", "scoped-value")
    expect_identical(Sys.getenv("UVR_TEST_VAR"), "scoped-value")
  })
  expect_identical(Sys.getenv("UVR_TEST_VAR", unset = NA), NA_character_)
})

test_that(".setup_env_var restores a pre-existing value", {
  withr::local_envvar(UVR_TEST_VAR = "original")

  local({
    .setup_env_var("UVR_TEST_VAR", "override")
    expect_identical(Sys.getenv("UVR_TEST_VAR"), "override")
  })
  expect_identical(Sys.getenv("UVR_TEST_VAR"), "original")
})

test_that(".setup_env_var with NULL leaves the environment untouched", {
  withr::local_envvar(UVR_TEST_VAR = "original")

  local({
    .setup_env_var("UVR_TEST_VAR", NULL)
    expect_identical(Sys.getenv("UVR_TEST_VAR"), "original")
  })
  expect_identical(Sys.getenv("UVR_TEST_VAR"), "original")
})

test_that(".setup_env_var rejects non-scalar values", {
  expect_error(.setup_env_var("UVR_TEST_VAR", c("a", "b")))
  expect_error(.setup_env_var("UVR_TEST_VAR", NA_character_))
  expect_error(.setup_env_var("UVR_TEST_VAR", 42))
})

test_that(".setup_cache_dir scopes UVR_CACHE_DIR", {
  Sys.unsetenv("UVR_CACHE_DIR")

  local({
    .setup_cache_dir("/tmp/custom-cache")
    expect_identical(Sys.getenv("UVR_CACHE_DIR"), "/tmp/custom-cache")
  })
  expect_identical(Sys.getenv("UVR_CACHE_DIR", unset = NA), NA_character_)
})

test_that("progress arg scopes UVR_PROGRESS during the call (#15)", {
  # add() with an invalid binary path fails, but must not leak UVR_PROGRESS
  Sys.unsetenv("UVR_PROGRESS")
  try(
    add(
      "jsonlite",
      progress = "never",
      bin = "/nonexistent/uvr",
      quiet = TRUE
    ),
    silent = TRUE
  )
  expect_identical(Sys.getenv("UVR_PROGRESS", unset = NA), NA_character_)
})
