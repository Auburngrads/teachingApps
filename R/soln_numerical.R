soln_numerical<- function() {

    app <- source(system.file("apps", "soln_numerical.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
