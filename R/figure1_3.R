figure1_3 <- function() {

    file <- system.file("apps", "figure1_3.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
