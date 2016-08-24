simultaneous_skills<- function() {

    app <- source(system.file("apps", "simultaneous_skills.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
