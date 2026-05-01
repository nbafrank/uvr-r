test_that("completions works for all shells", {
  path <- setup_uvr_test() # installs uvr if needed

  for (shell in c("bash", "zsh", "fish", "powershell")) {
    expect_no_error(completions(shell = shell, bin = path))
    # TODO: compare output with expected
  }
})
