figure1_1<- function() {

    app <- source(system.file("apps", "figure1_1.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
