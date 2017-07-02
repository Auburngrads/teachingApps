#' Add a branding logo to a teachingApp
#'
#' @param app_dir \code{character} Name of the app in which the signature will be placed
#' @param git_user \code{character} GitHub account username (typically created using teachingApps::setOptions()) 
#' @param app_pkg \code{character} Name of package in which \code{app_name} exists
#' @param icon \code{character} Name of a fontAwesome icon printed in the app footer
#' @param img \code{character} Path to an image printed in the app footer
#' 
#' @importFrom rprojroot find_root is_r_package
#' 
#' @return An icon or image logo in the footer of a navbarPage app
#' @export
add_logo <- 
function(app_dir, 
         git_user = NULL, 
         app_pkg = NULL,
         icon = NULL, 
         img = NULL) {
  
  if(is.null(icon) & is.null(img)) {
    
    logo <- paste("<i class=","'","fa fa-github fa-3x","'","></i>", sep = '')
    
  } else {
    
    `if`(is.null(img),
         logo <- paste("<i class=","'",icon," fa-3x'","></i>", sep = ''),
         logo <- paste("<img src='", img, "' width='30px' height='30px'>", sep = ''))
    
  }
  
  app_name <- basename(app_dir)
  
  if(is.null(git_user)) git_user <- 'Auburngrads'
  
  app_pkg <- basename(rprojroot::find_root(app_dir,
                                           criterion = is_r_package))
  
  gitURL  <- paste(c('https://github.com',git_user,app_pkg,'blob/master/inst/apps'),
                   collapse = '/')
  
    return(paste(c("<script src='https://use.fontawesome.com/6819c76733.js'></script>
                    <link href='teachingApps/font-awesome-4.5.0/css/font-awesome.min.css' rel='stylesheet'>
<ul class='photo-grid'>
<li>
<figure>",
logo, 
"<figcaption><p>Get the <a target=' ' href='",
                paste(c(gitURL, app_name), collapse = '/'),"'>CODE</a> for this app</p></figcaption>
</figure>
</li>
</ul>"), collapse = ''))
    
}
