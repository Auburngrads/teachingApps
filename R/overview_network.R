overview_network <- function() {

    file <- system.file("apps", "overview_network.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
