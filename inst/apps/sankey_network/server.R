server = function(input, output, session) {

 output$sankey1 <- networkD3::renderSankeyNetwork({
   
name <- c('Scraping Data', 'Cleaning Data', 'Analyzing Data', 'Summarizing Results', 'Visualizing Results')
nodes <- data.frame(name, stringsAsFactors = F)

source <- c(0:3)
target <- c(1:4)
value  <- c(1,1,2,5)

links <- data.frame(source, target, value)

networkD3::sankeyNetwork(Links = links, 
                         Nodes = nodes, 
                         Source = 'source', 
                         Target = 'target',
                         Value =  'value', 
                         NodeID = 'name',
                         nodeWidth = 3, 
                         width = 700)
})        
}