pdf_demo<- function() {

    app <- source(system.file("apps", "pdf_demo.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
