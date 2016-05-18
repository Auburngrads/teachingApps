teachingApp <- function(name,...) {
  
  if(!is.character(name)) stop('name must be a character string')
  
  gitFile <- paste(c(name,'.R'), collapse = '')
  gitURL  <- 'https://github.com/Auburngrads/teachingApps/blob/master/R'
  
    return(paste(c("<div style='font-size: 22pt; font-weight: normal;'>Get the <a href='",
                paste(c(gitURL, gitFile), collapse = '/'),"'>Code</a> for this app on GitHub</div>"), collapse = ''))
    
}