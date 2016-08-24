shockabsorber_surfaces<- function() {

    app <- source(system.file("apps", "shockabsorber_surfaces.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
