figure7_3 <- function() {

    file <- system.file("apps", "figure7_3.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
