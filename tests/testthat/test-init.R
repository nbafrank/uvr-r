test_that("init works", {
  path <- setup_uvr_test() # installs uvr if needed
  temp_dir <- dirname(tempfile()) |> file.path("uvr-test")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)

  # init runs without error and library directory is created
  expect_no_error(init(bin = path, dir = temp_dir))
  expect_true(dir.exists(file.path(temp_dir, ".uvr/library")))

  # basic uvr.toml is created and is formatted as expected
  expect_true(file.exists(file.path(temp_dir, "uvr.toml")))
  readLines(file.path(temp_dir, "uvr.toml")) |>
    paste(collapse = "\n") |>
    expect_equal(expected = "[project]\nname = \"uvr-test\"")

  # .Rprofile is created and is formatted as expected
  # (needs to have snapshot reviewed and accepted if .Rprofile changes)
  expect_true(file.exists(file.path(temp_dir, ".Rprofile")))
  readLines(file.path(temp_dir, ".Rprofile")) |>
    paste(collapse = "\n") |>
    cat() |>
    expect_snapshot()

  # .Rprofile runs without error
  uvr::run(script = ".Rprofile", bin = path, dir = temp_dir) |>
    expect_no_error()
})

# TODO: add tests for when DESCRIPTION exists

# TODO: add tests to verify uvr.toml in a range of conditions
# TODO: add tests to verify .Rprofile
