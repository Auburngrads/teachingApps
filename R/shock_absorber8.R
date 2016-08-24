shock_absorber8 <- function() {

    file <- system.file("apps", "shock_absorber8.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
