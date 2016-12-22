#' Leave signature for teachingApps 
#'
#' @param name The name of the app \code{character}
#'
#' @export
teachingApp <- function(name) {
  
  if(!is.character(name)) stop('name must be a character string')
  
  gitURL  <- 'https://github.com/Auburngrads/teachingApps/blob/master/inst/apps'
  
    return(paste(c("<ul class='photo-grid'>
<li>
<figure>
<img src='http://i.imgur.com/5DusfUM.gif'> 
<figcaption><p>Get the <a target=' ' href='",
                paste(c(gitURL, name), collapse = '/'),"'>CODE</a> for this app</p></figcaption>
</figure>
</li>
</ul>"), collapse = ''))
    
}