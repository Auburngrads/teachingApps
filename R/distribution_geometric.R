distribution_geometric <- function() {

    file <- system.file("apps", "distribution_geometric.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
