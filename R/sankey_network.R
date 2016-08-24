sankey_network <- function() {

    file <- system.file("apps", "sankey_network.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
