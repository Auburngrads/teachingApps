exp_numerical<- function() {

    app <- source(system.file("apps", "exp_numerical.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
