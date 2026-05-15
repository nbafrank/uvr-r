#' Generate shell completions (bash, zsh, fish, powershell)
#'
#' Equivalent to \code{uvr completions `shell`} on the command line.
#'
#' @param shell One of \code{"bash"}, \code{"zsh"}, \code{"fish"}, or \code{"powershell"}.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family uvr setup functions
#' @export
#' @examples
#' \dontrun{
#' completions("bash")
#' completions("zsh")
#' completions("fish")
#' completions("powershell")
#' }
completions <- function(
  shell = c("bash", "zsh", "fish", "powershell"),
  bin = NULL,
  quiet = FALSE
) {
  shell <- match.arg(shell)
  .validate_single_characters(list(bin = bin))
  .validate_flags(list(quiet = quiet))

  args <- c("completions", shell)
  run_uvr(args, bin = bin, quiet = quiet)
}
