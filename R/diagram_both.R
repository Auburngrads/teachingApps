diagram_both<- function() {

    app <- source(system.file("apps", "diagram_both.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
