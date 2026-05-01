test_that("find_uvr returns a path when uvr is installed", {
  skip_if_no_uvr()
  path <- find_uvr()
  expect_true(file.exists(path))
})
