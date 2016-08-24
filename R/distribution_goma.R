distribution_goma<- function() {

    app <- source(system.file("apps", "distribution_goma.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
