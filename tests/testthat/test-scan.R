test_that("scan reports a package the code uses but the manifest omits", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE)
  # jsonlite is used by the code but never added to uvr.toml.
  writeLines(
    "library(jsonlite)\ntoJSON(list(a = 1))\n",
    file.path(temp_dir, "analysis.R")
  )

  out <- scan(bin = path, dir = temp_dir, quiet = TRUE)
  expect_true(any(grepl("jsonlite", out, fixed = TRUE)))
})

test_that("scan(all = TRUE) is accepted", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE)
  writeLines("library(jsonlite)\n", file.path(temp_dir, "analysis.R"))

  expect_no_error(scan(all = TRUE, bin = path, dir = temp_dir, quiet = TRUE))
})

test_that("scan validates its flag before spawning uvr", {
  expect_error(scan(all = "yes"))
})
