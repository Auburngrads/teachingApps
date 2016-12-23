server = function(input, output, session) {
  
  output$visnet1 <- visNetwork::renderVisNetwork({
           
n.names <- list(
hub <- 'DATA SCIENCE',
nodes_1 <- c('Data\nMunging',
             'Data\nAnalysis',
             'Presenting\nResults',
             'Computer\nProgramming'),

nodes_1.1 <- c('Web\nScraping',
               'Cleaning',
               'Reshaping',
               'Filtering'),

nodes_1.2 <- c('Distribution\nFitting',
               'Linear\nModels',
               'Stochastic\nProcesses',
               'Confidence\nIntervals'),

nodes_1.3 <- c('JavaScript\nLibraries',
               'Data\nVisualization',
               'Interactive\nPlotting',
               'Reproducible\nResearch'),

nodes_1.4 <- c('R/Python/Julia',
               'HTML/CSS/JS',
               'Reproducible\nResearch',
               'Confidence\nIntervals'))

nodes <- data.frame(id = 1:length(unlist(n.names)), 
                    label = unlist(n.names), 
                    value = rep(c(4,2,1,1,1,1), 
                                times = lapply(n.names, length)),
                    color = rep(c('orange','blue','gray','gray','gray','gray'), 
                                times = lapply(n.names, length)))

edges <- data.frame(from = rep(1:5, times = c(4,4,4,4,4)), to = 2:length(unlist(n.names)))

visNetwork(nodes, edges, width = "100%", height = '100%') %>%
#visNodes(id = 'DATA SCIENCE',shape = "icon",icon = list(code = "f091", size = 100)) %>%
addFontAwesome() %>%
visOptions(highlightNearest = list(enabled =TRUE, degree = 0)) %>% 
visInteraction(navigationButtons = TRUE)
})
}