#' Add an update to a shiny app
#' 
#' @description Pass app updates from a local inst directory to an app in an installed package
#'
#' @importFrom utils browseURL
#' @importFrom rprojroot find_root is_r_package
#'
#' @param local_pkg \code{character} Path to the local version of the package from which updates will be passed
#' @param ... Additional directory names passed to \code{file.path()} (see details)
#' @param app_name \code{character} Name of the app to be updated
#' @param open_dir \code{logical} If \code{TRUE}, \code{browseURL()} is called to view the files in the app directory
#' @param update_css \code{logical} If \code{TRUE} the css file is updated
#'  
#' @details This function enables ultra-fast updates to shiny apps without
#'          needing to rebuild the package.  It is assumed that two versions 
#'          of a package exist on the user's machine.  The first version is 
#'          an installed package stored in the user's library, while the second 
#'          version is a pre-compiled (in-work) version of the package. This 
#'          function allows users to pass updates to an app from the in-work 
#'          version of the package to the installed version while ensuring that
#'          the app can be deployed/published.  Because files in the \code{inst/}
#'          directory aren't compiled when packages are built, updates can 
#'          be passed to an installed package.  This is useful for testing 
#'          changes made to an app without re-building the package each time.
#'          
#'          The \code{local_pkg} argument can be specified by providing a full file 
#'          path to any file in the uncompiled version of the package.  The root
#'          directory of the in-work package is located using \code{rprojroot::find_root}.  
#'          The root directory of the installed version of the package is located using 
#'          \code{devtools::inst()}. Any changes made to an app in the in-work package are 
#'          passed to the app within the installed version of the package stored in the 
#'          user's package library.
#'          
#'          The \code{...} arguments are passed \code{file.path()} and name the directories 
#'          between the package root directory and the \code{app_name/} directory. Note: the
#'          \code{inst} has already been provided and should not be included.  For \code{update_css=TRUE}
#'          the \code{...} argument specifies the directories between the package root and the 
#'          directory in which the css files are stored.
#'
#' @examples 
#' # In the \code{teachingApps} package, apps are stored in the 
#' # \code{inst/apps/} directory. 
#' \dontrun{ 
#' teachingApps::add_update(local_pkg = file.choose(),
#'                          'apps',
#'                          app_name = 'maximum_likelihood')
#' }
#' 
#' # Open an app directory to make and push updates
#' 
#' \dontrun{ 
#' teachingApps::add_update(local_pkg = file.choose(),
#'                          'apps',
#'                          app_name = 'maximum_likelihood',
#'                          open_dir = TRUE)
#' }
#' @export
add_update <- 
function(local_pkg,
         ...,
         app_name,
         open_dir = FALSE,
         update_css = FALSE) 
{

  local_pkg_root <- find_root(local_pkg, 
                               criterion = is_r_package)
  
    lib_pkg_root <- inst(basename(local_pkg_root))
   
  if(update_css) {
    
    file.copy(from = file.path(local_pkg_root,'inst',...), 
              to   = file.path(lib_pkg_root,...),
              recursive = T) 
    return(invisible())

    }
   
    local_app_dir <- file.path(local_pkg_root,'inst', ..., app_name) 
        
    if(!dir.exists(local_app_dir)) { 
      
        stop(app_name, 
             '" app not found in package:"',
             basename(local_pkg_root))
      }
      
    if(open_dir) return(utils::browseURL(local_app_dir))
      
    file.copy(from = file.path(local_app_dir), 
              to   = file.path(lib_pkg_root,..., app_name),
              recursive = T) 
}
