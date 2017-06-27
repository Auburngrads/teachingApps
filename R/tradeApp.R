#' Transfer an app between packages and/or directories
#' 
#' @description Moves (or 'trades') a directory containing a shiny app along with
#'    the app's calling function.
#'  
#' @param app_name \code{character} The name of a directory containing a shiny app. 
#' @param from \code{character} The name of an installed package, a file path, or a directory indicating the location from which the app and calling function will be traded. (see details)
#' @param to \code{character} A file path or a directory indicating the location to which the app and calling function will be traded. (see details) 
#' @param remove \code{logical} If \code{TRUE}, the app and calling function files will be removed from \code{from}.
#' 
#' @details
#' \code{tradeApp} is a wrapper function for performing three types 
#' of app 'trades': 
#' 
#' \itemize{
#'  \item package-to-package - trade an app and calling function from one package to another
#'  \item package-to-directory - trade an app and calling function from a package to a local directory
#'  \item directory-to-package - trade an app and calling function from a local directory to a package
#'  }
#'   
#' These three trade types should cover most use-cases.  The type 
#' of trade that is performed depends on what is provided to the 
#' arguments \code{from} and \code{to}. See the sections "The Argument 
#' \code{from}" and "The Argument \code{to}" below for more details. 
#'
#' @section The \code{from} Argument:
#' 
#' The \code{from} argument may be specified in one of the following three ways:
#' \describe{
#' \item{An installed package}{If \code{from} is the name of an installed package, 
#' \code{installed.packages()} is called to verify that the package
#' exists in the user's library.  If the package is found, the function 
#' locates the subdirectory \code{from/apps/app_name} and copies
#' the files to location provided by the argument \code{to} 
#' using \code{R.utils::copyDirectory()}.}
#' 
#' \item{A file}{If \code{from} is the full path to a file, \code{rprojroot::find_root()} 
#' is called to determine if the file is part of an installed package, a local package,
#' or a standalone shiny app, and then locates the \code{app_name/} directory. If
#' the \code{app_name/} directory exists, the files are copied to the location provided by 
#' the argument \code{to} using \code{R.utils::copyDirectory()}.}
#' 
#' \item{A directory}{If \code{from} is the full path to a directory,\code{rprojroot::find_root()} 
#' is called to determine if the directory is part of an installed package, a local package,
#' or a standalone shiny app, and then locates the \code{app_name/} directory. If
#' the \code{app_name/} directory exists, the files are copied to the location provided by 
#' the argument \code{to} using \code{R.utils::copyDirectory()}.}
#' }
#' 
#' @section The \code{to} Argument:
#' 
#' The \code{to} argument may be specified in one of the following two ways:
#' \describe{
#' \item{A file}{If \code{to} is the full path to a file in a local package, 
#' the function searches for the \code{inst/apps/app_name/} directory. If not found
#' the directory will created and the files will be copied.  
#' is called to determine if the file is part of a local package,
#' or a standalone shiny app, and then locates the \code{app_name/} directory. If
#' the \code{app_name/} directory exists, the files are copied to the location provided by 
#' the argument \code{to} using \code{R.utils::copyDirectory()}.}
#' 
#' \item{A directory}{If \code{to} is the full path to a directory,\code{rprojroot::find_root()} 
#' is called to determine if the directory is part of an installed package, a local package,
#' or a standalone shiny app, and then locates the \code{app_name/} directory. If
#' the \code{app_name/} directory exists, the files are copied to the location provided by 
#' the argument \code{to} using \code{R.utils::copyDirectory()}.}
#' }
#' 
#' @return A printed shiny app
#' @export
tradeApp <- 
function(app_name, 
         from = 'teachingApps', 
         to = NULL, 
         remove = F) 
{
  
  From <- what_are_you(from)
  
    To <- what_are_you(to)
  
  if(From$package & To$package) {
    appExists(From,app = app_name)
    
    tradeApp_pkg_pkg(app = app_name,
                     pkg_from = From$pkgroot,
                     pkg_to = To$pkgroot,
                     remove = remove)
  }
  
  if(From$package & !To$package) {
    
    appExists(From, app = app_name)
    
    tradeApp_pkg_dir(app = app_name,
                     pkg_from = From$pkgroot,
                     dir_to = To$path,
                     remove = remove)
  }
  
  if(!From[[1]] & To[[1]]) {
    
    tradeApp_dir_pkg(app = app_name,
                     dir_from = From$path,
                     pkg_to = To$pkgroot,
                     remove = remove)
  }
  
  if(!From[[1]] & !To[[1]]) {
    
    tradeApp_dir_dir(app = app_name,
                     dir_from = From$path,
                     dir_to = To$path,
                     remove = remove)
  }
  
}
