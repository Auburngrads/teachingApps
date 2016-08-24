survival_demo<- function() {

    app <- source(system.file("apps", "survival_demo.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
