berkson200_profile<- function() {

    app <- source(system.file("apps", "berkson200_profile.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
