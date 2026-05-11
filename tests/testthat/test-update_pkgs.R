test_that("update_pkgs works", {
  temp_dir <- dirname(tempfile()) |> file.path("uvr-test")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed
  
  init(bin = path, dir = temp_dir)
  add("jsonlite", bin = path, dir = temp_dir)

  expect_no_error(update_pkgs(sync = FALSE, bin = path, dir = temp_dir))
  expect_no_error(update_pkgs(bin = path, dir = temp_dir))
  # TODO: inspect files
})
