teachingApp <- function(name,...) {
  
  if(!is.character(name)) stop('name must be a character string')
  
  gitFile <- paste(c(name,'.R'), collapse = '')
  gitURL  <- 'https://github.com/Auburngrads/teachingApps/blob/master/R'
  
    return(paste(c("<div style='font-size: 22pt; margin: 0 0 20px 30px; font-weight: normal;'>Get the [code](",
                paste(c(gitURL, gitFile), collapse = '/'),') for this app on GitHub</div>'), collapse = ''))
    
}