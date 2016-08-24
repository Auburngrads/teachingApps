shock_absorber8<- function() {

    app <- source(system.file("apps", "shock_absorber8.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
