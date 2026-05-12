#' Generate shell completions (bash, zsh, fish, powershell)
#'
#' Equivalent to \code{uvr completions `shell`} on the command line.
#'
#' @param shell One of \code{"bash"}, \code{"zsh"}, \code{"fish"}, or \code{"powershell"}.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @export
completions <- function(shell, bin = NULL, quiet = FALSE) {
  stopifnot(
    length(shell) == 1L,
    shell %in% c("bash", "zsh", "fish", "powershell"),
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.logical(quiet) && !is.na(quiet) && length(quiet) == 1L
  )

  args <- c("completions", shell)
  run_uvr(args, bin = bin, quiet = quiet)
}
