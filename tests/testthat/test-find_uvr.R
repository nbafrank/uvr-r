skip_if_no_uvr <- function() {
  candidate_path <- file.path(.get_home_dir(), ".cargo", "bin", "uvr")
  skip_if_not(
    nzchar(Sys.which("uvr")) || file.exists(candidate_path),
    message = "uvr binary not found"
  )
}

test_that("find_uvr returns a path when uvr is installed", {
  skip_if_no_uvr()
  path <- find_uvr()
  expect_true(file.exists(path))
})

test_that("run_uvr errors on bad command", {
  skip_if_no_uvr()
  expect_error(run_uvr("--nonexistent-flag"), "exited with code")
})

test_that("add errors on empty packages", {
  expect_error(add(character(0)), "length\\(packages\\) > 0L")
})

test_that("remove_pkgs errors on empty packages", {
  expect_error(remove_pkgs(character(0)), "length\\(packages\\) > 0L")
})

test_that("run requires script argument", {
  expect_error(run(), "missing")
})

test_that("install_uvr returns early when already installed", {
  skip_if_no_uvr()
  expect_message(install_uvr(force = FALSE), "already installed")
})

test_that("install_uvr(method='binary') stops when no binary available", {
  skip_if_no_uvr()
  # Mock .try_install_binary to return NULL
  mockenv <- new.env(parent = asNamespace("uvr"))
  local({
    # Force .find_uvr_path to return NULL so it doesn't short-circuit
    assign(".find_uvr_path", function() NULL, envir = parent.env(environment()))
    assign(
      ".try_install_binary",
      function() NULL,
      envir = parent.env(environment())
    )
  })
  expect_error(
    withr::with_environment(
      mockenv,
      install_uvr(method = "binary", force = TRUE)
    ),
    "No pre-built binary"
  )
})
