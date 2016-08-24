diagram_nonrepairable<- function() {

    app <- source(system.file("apps", "diagram_nonrepairable.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
