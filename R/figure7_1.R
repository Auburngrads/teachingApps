figure7_1 <- function() {

    file <- system.file("apps", "figure7_1.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
