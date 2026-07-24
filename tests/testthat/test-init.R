test_that("init works", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  # init runs without error and library directory is created
  expect_no_error(init(bin = path, dir = temp_dir, quiet = TRUE))
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
  uvr::run(script = ".Rprofile", bin = path, dir = temp_dir, quiet = TRUE) |>
    expect_no_error()
})

test_that("init with a custom name creates a subdirectory project (#17)", {
  # `uvr init <name>` scaffolds ./<name>/ (cargo-new style), not the cwd
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir)

  expect_no_error(
    init(name = "custom-project", bin = path, dir = temp_dir, quiet = TRUE)
  )
  project_dir <- file.path(temp_dir, "custom-project")
  expect_true(dir.exists(project_dir))
  toml <- readLines(file.path(project_dir, "uvr.toml"))
  expect_true(any(grepl('name = "custom-project"', toml, fixed = TRUE)))
})

test_that("init with an R version constraint records it (#17)", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir)

  expect_no_error(
    init(r_version = ">=4.1", bin = path, dir = temp_dir, quiet = TRUE)
  )
  toml <- paste(readLines(file.path(temp_dir, "uvr.toml")), collapse = "\n")
  expect_match(toml, ">=4.1", fixed = TRUE)
})

test_that("init fails when a manifest already exists (#17)", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE)

  expect_error(
    init(bin = path, dir = temp_dir, quiet = TRUE),
    "uvr exited with code"
  )
})

test_that("init reads dependencies from an existing DESCRIPTION (#17)", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir)

  writeLines(
    c(
      "Package: testpkg",
      "Version: 0.1.0",
      "Imports:",
      "    jsonlite"
    ),
    file.path(temp_dir, "DESCRIPTION")
  )
  expect_no_error(init(bin = path, dir = temp_dir, quiet = TRUE))
  toml <- paste(readLines(file.path(temp_dir, "uvr.toml")), collapse = "\n")
  expect_match(toml, "jsonlite", fixed = TRUE)
})
