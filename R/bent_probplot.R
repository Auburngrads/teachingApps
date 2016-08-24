bent_probplot <- function() {

    file <- system.file("apps", "bent_probplot.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
