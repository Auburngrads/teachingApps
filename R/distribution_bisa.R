distribution_bisa<- function() {

    app <- source(system.file("apps", "distribution_bisa.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
