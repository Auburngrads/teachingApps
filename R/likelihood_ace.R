likelihood_ace <- function() {

    file <- system.file("apps", "likelihood_ace.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
