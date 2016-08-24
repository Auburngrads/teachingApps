figure7_2 <- function() {

    file <- system.file("apps", "figure7_2.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
