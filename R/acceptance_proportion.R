acceptance_proportion <- function() {

    file <- system.file("apps", "acceptance_proportion.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
