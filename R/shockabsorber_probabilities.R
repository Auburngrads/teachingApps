shockabsorber_probabilities<- function() {

    app <- source(system.file("apps", "shockabsorber_probabilities.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
