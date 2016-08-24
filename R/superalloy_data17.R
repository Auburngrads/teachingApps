superalloy_data17 <- function() {

    file <- system.file("apps", "superalloy_data17.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
