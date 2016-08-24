distribution_norgets<- function() {

    app <- source(system.file("apps", "distribution_norgets.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
