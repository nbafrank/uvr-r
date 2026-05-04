test_that("remove_pkgs works and errors on empty packages", {
  path <- setup_uvr_test() # installs uvr if needed
  temp_dir <- dirname(tempfile()) |> file.path("uvr-test")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)

  init(bin = path, dir = temp_dir)
  add("jsonlite", bin = path, dir = temp_dir)
  expect_no_error(remove_pkgs("jsonlite", bin = path, dir = temp_dir))
  expect_error(remove_pkgs(character(0)), "length\\(packages\\) > 0L")

  # TODO: test that package removed correctly
})
