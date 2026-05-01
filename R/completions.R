#' Generate shell completions (bash, zsh, fish, powershell)
#'
#' Equivalent to \code{uvr completions `shell`} on the command line.
#'
#' @param shell One of \code{"bash"}, \code{"zsh"}, \code{"fish"}, or \code{"powershell"}.
#' @inheritParams run_uvr
#' @return Shell completions for the specified \code{shell}.
#' @export
completions <- function(shell, quiet = FALSE) {
  stopifnot(
    length(shell) == 1L,
    shell %in% c("bash", "zsh", "fish", "powershell"),
    is.logical(quiet) && length(quiet) == 1L
  )
  args <- c("completions", shell)
  run_uvr(args, quiet = quiet)
}
