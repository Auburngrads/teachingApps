pdf_demo <- function() {

    file <- system.file("apps", "pdf_demo.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
