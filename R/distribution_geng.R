distribution_geng<- function() {

    app <- source(system.file("apps", "distribution_geng.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
