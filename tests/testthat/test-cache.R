test_that("cache_clean works", {
  path <- setup_uvr_test() # installs uvr if needed
  
  expect_no_error(cache_clean(bin = path)) # TODO: prevent side effects
})