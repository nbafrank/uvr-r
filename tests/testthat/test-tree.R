test_that("tree lists the dependency graph", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE)
  add("jsonlite", do_install = FALSE, bin = path, dir = temp_dir, quiet = TRUE)

  out <- tree(bin = path, dir = temp_dir, quiet = TRUE)
  expect_true(any(grepl("jsonlite", out, fixed = TRUE)))
})

test_that("tree honors depth", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE)
  add("jsonlite", do_install = FALSE, bin = path, dir = temp_dir, quiet = TRUE)

  expect_no_error(tree(depth = 1, bin = path, dir = temp_dir, quiet = TRUE))
})

test_that("tree rejects a non-numeric depth before shelling out", {
  # Catching this in R gives a better message than uvr's arg parser would,
  # and costs nothing since no process is spawned.
  expect_error(tree(depth = "one"))
  expect_error(tree(depth = -1))
})
