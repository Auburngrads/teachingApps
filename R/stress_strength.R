stress_strength<- function() {

    app <- source(system.file("apps", "stress_strength.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
