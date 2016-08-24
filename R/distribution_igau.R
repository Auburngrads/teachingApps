distribution_igau<- function() {

    app <- source(system.file("apps", "distribution_igau.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
