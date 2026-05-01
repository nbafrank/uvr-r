test_that("remove_pkgs errors on empty packages", {
  expect_error(remove_pkgs(character(0)), "length\\(packages\\) > 0L")
})
