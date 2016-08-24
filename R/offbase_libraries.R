offbase_libraries <- function() {

    file <- system.file("apps", "offbase_libraries.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
