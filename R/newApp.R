#' Create a new teachingApp
#'
#' @description Wrapper function to create a new teachingApp 
#'
#' @param appName The name of the new teachingApp
#' @param pkg.path Absolute path to DESCRIPTION file for the package in which the app will reside 
#' @param storyteller Will this be a storyteller teachingApp? 
#' @param pkg Package in which this app will reside (defaults to 'teachingApps') 
#' @export

newApp <- 
function(appName, pkg = 'teachingApps',
         pkg.path = NULL, storyteller = F) {
  
  `if`(storyteller,
       navbarApp(appName = appName, pkg = pkg, pkg.path = pkg.path),
       fluidApp(appName = appName, pkg = pkg, pkg.path = pkg.path))
  
}




fluidApp <- 
function(appName, pkg = 'teachingApps',pkg.path = NULL)
{
  
  template <- system.file('resources',
                          'templates',
                          'fluidpage.R', 
                          package = 'teachingApps')
  
  `if`(is.null(pkg.path),
       root <- paste(c(options('gitHome'),pkg), collapse = '/'),
       root <- paste(c(dirname(pkg.path)),      collapse = '/'))
  
   lines <- readLines(template)

   new.text <- c()
   
   for(i in 1:length(lines)) {
  
       new.text[i] <- gsub("newAppName",appName, lines[i] )

   }

  new.file <- paste(c(root,'/R/',appName,'.R'), collapse = '')
  new.dir <- paste(c(root,'/inst/apps/',appName), collapse = '')
  
  if(!file.exists(new.file)) file.create(new.file)
  if(!dir.exists(new.dir)) dir.create(new.dir)

  writeLines(new.text, con = new.file)
  
  file.create(paste(c(new.dir,'/global.R'), collapse = ''))

      new_fluid_UI(dir = new.dir, name = appName)
  
  new_fluid_Server(dir = new.dir, name = appName)
  
}





navbarApp <- 
function(appName, pkg = 'teachingApps',pkg.path = NULL)
{
  
  template <- system.file('resources',
                          'templates',
                          'navbarpage.R', 
                          package = 'teachingApps')
  
  `if`(is.null(pkg.path),
       root <- paste(c(options('gitHome'),pkg), collapse = '/'),
       root <- paste(c(dirname(pkg.path)),      collapse = '/'))
  
  
   lines <- readLines(template)

   for(i in 1:length(lines)) {
  
       new.text[i] <- gsub('newAppName','stuff', lines[i] )

   }

  new.file <- paste(c(root,'/R/',appName,'.R'), collapse = '')
  
  if(!file.exists(new.file)) file.create(new.file)

  writeLines(new.text, new.file)
  
  new.dir <- paste(c(root,'/inst/apps/',appName), collapse = '')
  
  if(!dir.exists(new.dir)) dir.create(new.dir)
  
  file.create(paste(c(new.dir,'/global.R'), collapse = ''))
  
  file.copy(from = system.file('resources','templates','navbarUI.R', package = 'teachingApps'),
            to   = paste(c(new.dir, 'ui.R'), collapse = '/'))
  file.copy(from = system.file('resources','templates','navbarServer.R', package = 'teachingApps'),
            to   = paste(c(new.dir, 'server.R'), collapse = '/'))
  
}





new_fluid_UI <- 
function(dir, name) {
  
  if(!file.exists(paste(c(dir, 'ui.R'), collapse = '/'))) {
    
if(file.copy(from = system.file('resources','templates','fluidUI.R', package = 'teachingApps'),
             to   = paste(c(dir, 'ui.R'), collapse = '/')))
   cat(paste(c('ui.R created for',name, 'app\n' ), collapse = ' '))
  
} else {
  
  cat(paste(c('ui.R exists for',
              name,
              "app and won't be overwritten\n"),
            collapse = ' '))
  
}
}





new_fluid_Server <- 
function(dir, name) {
  
  if(!file.exists(paste(c(dir, 'server.R'), collapse = '/'))) {
  
if(file.copy(from = system.file('resources','templates','fluidServer.R', package = 'teachingApps'),
             to   = paste(c(dir, 'server.R'), collapse = '/')))
   cat(paste(c('server.R created for',name, 'app\n' ), collapse = ' '))
  
} else {
  
  cat(paste(c('server.R exists for',
              name,
              "app and won't be overwritten\n"),
            collapse = ' '))
  
}
}
