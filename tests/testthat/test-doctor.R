test_that("doctor works", {
  temp_dir <- dirname(tempfile()) |> file.path("uvr-test")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  expect_no_error(doctor(bin = path))
})
