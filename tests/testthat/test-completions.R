test_that("completions works for all shells", {
  temp_dir <- dirname(tempfile()) |> file.path("uvr-test")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  for (shell in c("bash", "zsh", "fish", "powershell")) {
    expect_no_error(completions(shell = shell, bin = path))
    # TODO: compare output with expected
  }
})
