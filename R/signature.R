#' Place a signature on a teachingApp
#'
#' @param app.name \code{character} Name of the app in which the signature will be placed
#' @param git.username \code{character} GitHub account username (typically created using teachingApps::setOptions()) 
#' @param appPackage \code{character} Name of package in which \code{app.name} exists
#'
#' @export
signature <- 
function(app.name, git.username = NULL, appPackage = NULL,
         icon = NULL, img = NULL) {
  
  if(is.null(icon) & is.null(img)) {
    
    logo <- paste("<i class=","'","fa fa-github fa-3x","'","></i>", sep = '')
    
  } else {
    
    `if`(is.null(img),
         logo = paste("<i class=","'",icon,"'","></i>", sep = ''),
         logo = paste("<img src='", img, "'>", sep = ''))
    
  }
  
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
<figure>",
logo, 
"<figcaption><p>Get the <a target=' ' href='",
                paste(c(gitURL, app.name), collapse = '/'),"'>CODE</a> for this app</p></figcaption>
</figure>
</li>
</ul>"), collapse = ''))
    
}