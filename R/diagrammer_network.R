diagrammer_network <- function() {

    file <- system.file("apps", "diagrammer_network.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
