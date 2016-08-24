acceptance_mtbf<- function() {

    app <- source(system.file("apps", "acceptance_mtbf.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
