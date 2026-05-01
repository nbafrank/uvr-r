test_that("find_uvr returns a path when uvr is installed", {
  path <- find_uvr()

  # Try installing if not found 
  if (!file.exists(path)) {
    install_uvr()
  }
  path <- find_uvr()
  expect_true(file.exists(path))
})
