probability_plotting <- function() {

    file <- system.file("apps", "probability_plotting.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
