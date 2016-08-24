distribution_levgets<- function() {

    app <- source(system.file("apps", "distribution_levgets.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
