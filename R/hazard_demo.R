hazard_demo<- function() {

    app <- source(system.file("apps", "hazard_demo.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
