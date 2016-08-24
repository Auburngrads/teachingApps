acceptance_mtbf <- function() {

    file <- system.file("apps", "acceptance_mtbf.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
