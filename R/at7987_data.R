#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#'
#' @param pub Will this app be published? (see details)
#'
#' @details When publishing apps using shinyapps.io or shinyServer, set \code{pub = TRUE} to prevent calls to \code{install.packages}. Calls to \code{install.packages} should not be included within an app and will result in an error.
#'
#' @export

at7987_data <- function(pub = FALSE) {

    file <- system.file("apps", "at7987_dataapp.R", package = "teachingApps")

    getPackage("plotly", pub = pub)
    getPackage("miniUI", pub = pub)

    shiny::runApp(file)
  
}
