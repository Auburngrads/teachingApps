#' Determine if a file is in a shiny app directory
#' 
#' @importFrom rprojroot root_criterion
#' 
#' @export
is_shiny_app <- 
  root_criterion(function(path) file.exists(any(file.path(path, "ui.R"),
                                                file.path(path, "app.R"))), 
                                            "has ui.R or app.R")