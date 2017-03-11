#' Transfer a teachingApp from a package to a local directory
#' 
#' @param app \code{character} The app name
#' @param pkg_from \code{character} The package from which the app will be traded (see details)
#' @param dir_to \code{character} The directory to which the app will be traded (see details) 
#' @param remove \code{logical} If \code{TRUE}, the app and calling function will be removed from \code{from}.
#'
#' @importFrom R.utils copyDirectory
#' @importFrom R.utils removeDirectory
#' @importFrom utils capture.output
#' @importFrom utils browseURL
#' 
#' @details see ?teachingApps::tradeApp
tradeApp_pkg_dir <- 
function(app, 
         pkg_from = 'teachingApps', 
         dir_to = NULL,
         remove = remove) 
{
  
  main.app.dir <- paste(dir_to,'/app-',app, sep = '')
  this.app.dir <- file.path(main.app.dir, app)
  
  if(!dir.exists(main.app.dir)) dir.create(main.app.dir)
  
  if(!dir.exists(this.app.dir)) {
    
       dir.create(this.app.dir)
    
       R.utils::copyDirectory(from = file.path(pkg_from,'apps', app),
                              to = this.app.dir)
    
  } else {
    
    overwrite <- readline(prompt = message('\nA directory with this name already exists.\n\nDo you want to overwrite these files? (y/n)\n'))
    
    if(!any(startsWith(tolower(overwrite), c('y','n')))) {
      
      message('\nImproper response - use either "y" or "n".\n\nProcess Terminated')
      return()
    }
    if(startsWith(tolower(overwrite), 'n')) {
      
      message('\nProcess terminated by user - app not moved')
      return()
    }
    if(startsWith(tolower(overwrite), 'y')) {
      
      R.utils::copyDirectory(from = file.path(pkg_from,'apps', app),
                             to = this.app.dir)
      
    }
  }
  
  # Move calling function
  calling.function.id <- paste(basename(pkg_from), app, sep = '::')
  
  calling.function.body <- capture.output(eval(parse(text = calling.function.id)))
  
  cfb.length <- length(calling.function.body)
  
  review <- lapply(X = 1:cfb.length, 
                   FUN = function(x) grep('dir <-',
                                          calling.function.body[x]))
  
  replace.path <- paste('    ','dir <- ','"',this.app.dir,'"', sep = '')
  
  calling.function.body[which(review==1)] <- replace.path
  
  calling.function.file <- paste(app,'R', sep = '.')
  
  writeLines(c(paste(app, '<- \n'),calling.function.body[-cfb.length]),
             con = file.path(main.app.dir, calling.function.file))

  on.exit({ 
    browseURL(main.app.dir)
    if(remove) R.utils::removeDirectory(file.path(pkg_from,'apps', app))
    source(file.path(main.app.dir, calling.function.file))
  })
  
}