shockabsorber_profiles<- function() {

    app <- source(system.file("apps", "shockabsorber_profiles.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
