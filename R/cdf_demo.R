cdf_demo<- function() {

    app <- source(system.file("apps", "cdf_demo.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
