distribution_lev<- function() {

    app <- source(system.file("apps", "distribution_lev.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
