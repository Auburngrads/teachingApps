data_science<- function() {

    app <- source(system.file("apps", "data_science.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
