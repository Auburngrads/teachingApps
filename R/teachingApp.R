#' Leave signature for a teachingApp
#'
#' @param app.name Name of the app \code{character}
#' @param git.username GitHub username (typically created using teachingApps::setOptions()) 
#' @param appPackage Name of package in which \code{app.name} exists
#' 
#' @export
teachingApp <- 
function(app.name, git.username = NULL, appPackage = NULL) {
  
  if(!is.character(app.name)) stop('name must be a character string')
  
  if(is.null(git.username)) { 
    
   `if`(is.null(getOption('git.username')),
        git.username <- 'Auburngrads',
        git.username <- getOption('git.username'))
    
  }
  
  if(is.null(appPackage))  { 
    
    `if`(is.null(getOption('appPackage')),
         appPackage <- 'teachingApps',
         appPackage <- getOption('appPackage'))
    
  }
  
  gitURL  <- paste(c('https://github.com',git.username,appPackage,'blob/master/inst/apps'),
                   collapse = '/')
  
    return(paste(c("<script src='https://use.fontawesome.com/6819c76733.js'></script>
<ul class='photo-grid'>
<li>
<figure>
<i class='fa fa-github fa-3x'></i>
<img src='...'> 
<figcaption><p>Get the <a target=' ' href='",
                paste(c(gitURL, app.name), collapse = '/'),"'>CODE</a> for this app</p></figcaption>
</figure>
</li>
</ul>"), collapse = ''))
    
}