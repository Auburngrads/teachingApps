figure1_9 <- function() {

    file <- system.file("apps", "figure1_9.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
