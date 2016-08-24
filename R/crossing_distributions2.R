crossing_distributions2 <- function() {

    file <- system.file("apps", "crossing_distributions2.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
