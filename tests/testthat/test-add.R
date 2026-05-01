test_that("add errors on empty packages", {
  expect_error(add(character(0)), "length\\(packages\\) > 0L")
})
