distribution_normal<- function() {

    app <- source(system.file("apps", "distribution_normal.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
