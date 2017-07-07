#' Create a branding logo for a teachingApp
#'
#' @param app_dir \code{character} Directory in which the app files are located
#' @param git_user \code{character} GitHub account username (see details) 
#' @param icon \code{character} Name of a fontAwesome icon printed in the app footer
#' @param img \code{character} Path to an image printed in the app footer
#' 
#' @importFrom rprojroot find_root is_r_package
#' @details This function should not be called directly, but is invoked by
#'          \code{add_optionss} when an app is rendered.  
#'          
#'          By default, the branding logo is the GitHub fontAwesome icon 
#'          ('fa fa-github'). If \code{img} is specified, it takes precedence
#'          oven \code{icon}. 
#'          
#'          Hovering over the logo will reveal a link to view the code used to 
#'          create the app. This is helpful in a teaching environment, where 
#'          students often are interested in understanding how an app functions. 
#'          The URL for the link is of the form (https://github.com\code{git_user}\code{app_pkg}blob/master/inst/apps)
#'          where \code{app_pkg} is created dynamically. 
#' 
#' @return HTML code for inserting a logo (icon or image) in the footer of a navbarPage app
#' @seealso \code{\link{add_options}}
#' @seealso \code{\link{add_logo}}
#' @export
create_logo <- 
function(app_dir = NULL, 
         git_user = NULL, 
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
  
    return(paste(c("<link href='teachingApps/font-awesome-4.5.0/css/font-awesome.min.css' rel='stylesheet'>
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



#' Adds a branding logo to the footer of a navbarPage app 
#'
#' @importFrom shiny includeCSS getShinyOption tags HTML
#' 
#' @param app_dir \code{character} Directory in which the app files are located
#' @param git_user \code{character} GitHub account username (see details) 
#' @param icon \code{character} Name of a fontAwesome icon printed in the app footer
#' @param img \code{character} Path to an image printed in the app footer
#' 
#' @return A fontAwesome icon or an image printed in the footer of a
#'         navbarPage app 
#' @seealso \code{\link{create_logo}}
#' 
#' @export
add_logo <- 
  function(app_dir = getShinyOption('appDir'), 
           git_user = getShinyOption('gitUser'), 
           icon = getShinyOption('icon'), 
           img = getShinyOption('img')) 
{
    
    shiny::addResourcePath("teachingApps", 
                       system.file("teachingApps", package = "teachingApps"))  

   HTML(create_logo(app_dir = app_dir,
               git_user = git_user,
               icon = icon,
               img = img))
    
}
