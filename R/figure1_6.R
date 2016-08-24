figure1_6 <- function() {

    file <- system.file("apps", "figure1_6.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
