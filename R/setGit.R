#' Set options for git
#'
#' @param home Directory in which git repositories are stored
#' 
#' @export

setGit <- function(home) {
  
  options <- getOption('git')
  
  if (missing(home)) { stop('Required variable "home" missing')
    
  } else { options$home <- home
  }
  
    class(options) <- "git_credentials"
    options(git = options)
    invisible(NULL)
}
