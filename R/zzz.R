.onLoad <- function(libname, pkgname) {
  
# options('appURL' = 'https://afit.shinyapps.io/')
  
}

#' Custom \code{par} function
#' 
#' @param ... Parameter passed to \code{par} in addition to those defined
#' 
#' @importFrom graphics par
#' 
#' @export
jkf.par <- function(...) {
    
    par(cex.lab=1.05,
        cex.axis=1.05,
        mgp=c(2.25,.7,0),
        tcl=-.3,
        font.lab=2,
        font=2,
        font.axis=2,
        las=1,
        tck=0.015,
        family='serif',...)
}


#' Leave signature for teachingApps 
#'
#' @param name The name of the app \code{character}
#'
#' @export
teachingApp <- function(name) {
  
  if(!is.character(name)) stop('name must be a character string')
  
  gitFile <- paste(c(name,'app.R'), collapse = '/')
  gitURL  <- 'https://github.com/Auburngrads/teachingApps/blob/master/inst/apps'
  
    return(paste(c("<ul class='photo-grid'>
<li>
<figure>
<img src='http://i.imgur.com/5DusfUM.gif'> 
<figcaption><p>Get the <a target=' ' href='",
                paste(c(gitURL, gitFile), collapse = '/'),"'>CODE</a> for this app</p></figcaption>
</figure>
</li>
</ul>"), collapse = ''))
    
}

createFun <- function() {
  
  dir = "C:\\Users\\Jason\\OneDrive\\Work-Stuff\\Computer Systems\\GitHub\\teachingApps\\inst\\apps"
  
  #dir = dirname(file)
  
  apps <- list.files(dir)
  
  #names <- gsub('.R', '', list.files(dir))
  
  for(i in 1:length(apps)) {
    
    app  <- system.file("apps", apps[i], "app.R", package = "teachingApps")
    pkgs <- readLines(app)[1:10]
    pkgs <- pkgs[sapply(pkgs, nchar) > 0]
    pkgs <- gsub('#', '', pkgs)
    pkgs <- gsub("')", "')", pkgs)
    
    text <- paste(c("#' Function Title\n",
                    "#'\n",
                    "#' @description Description\n",
                    "#'\n",
                    "#' @import shinythemes\n",
                    "#' @import shinyAce\n",
                    "#' @import shiny\n",
                    "#'\n", 
                    "#'\n",
                    "#'\n", 
                    "#' @details When publishing apps using shinyapps.io or shinyServer, set \\code{pub = TRUE} to prevent calls to \\code{install.packages}. Calls to \\code{install.packages} should not be included within an app and will result in an error.\n",
                    "#'\n",
                    "#' @export\n\n",apps[i],
                    ' <- function(pub = FALSE) {

    dir <- dirname(system.file("apps", "', apps[i],'", "app.R", package = "teachingApps"))

    ',paste(c(pkgs), collapse = '\n'),'

    shiny::runApp(file)
  
}'), collapse = '')
  
    file2 <- "C:\\Users\\Jason\\OneDrive\\Work-Stuff\\Computer Systems\\GitHub\\teachingApps\\R\\zzz.R"
    dir2  <- dirname(file2)
    
    writeLines(text = text, con = paste(c(dir2,'/',apps[i],'.R'), collapse = ''))
}
}