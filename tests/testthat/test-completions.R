test_that("completions works for all shells", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  for (shell in c("bash", "zsh", "fish", "powershell")) {
    result <- expect_no_error(
      completions(shell = !!shell, bin = path, quiet = TRUE)
    )
    expect_true(length(result) > 0L && is.character(result))
  }
})
