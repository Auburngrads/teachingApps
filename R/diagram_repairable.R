diagram_repairable<- function() {

    app <- source(system.file("apps", "diagram_repairable.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
