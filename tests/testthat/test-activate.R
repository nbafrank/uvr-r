test_that("activate prints the shell instructions", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE)

  out <- activate(bin = path, dir = temp_dir, quiet = TRUE)
  expect_true(any(grepl("activate", out, fixed = TRUE)))
})

test_that("activate(write_shim = TRUE) backfills a deleted shim", {
  # The case this exists for: a project created before shims existed, or
  # one where .uvr/ was cleaned. The shim holds no paths, so rewriting it
  # is always safe.
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE)
  shim <- file.path(temp_dir, ".uvr", "activate")
  unlink(shim)

  activate(write_shim = TRUE, bin = path, dir = temp_dir, quiet = TRUE)
  expect_true(file.exists(shim))
})

test_that("activate validates its flag before spawning uvr", {
  expect_error(activate(write_shim = "yes"))
})
