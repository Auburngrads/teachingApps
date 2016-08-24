shockabsorber_quantiles<- function() {

    app <- source(system.file("apps", "shockabsorber_quantiles.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
