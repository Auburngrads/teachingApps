htmlwidgets_shiny<- function() {

    app <- source(system.file("apps", "htmlwidgets_shiny.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
