server = function(input, output, session) {

 output$sankey1 <- networkD3::renderSankeyNetwork({
   
name <- c('Scraping Data', 'Cleaning Data', 'Analyzing Data', 'Summarizing Results', 'Visualizing Results')
nodes <- data.frame(name, stringsAsFactors = F)

source <- c('Scraping Data', 'Cleaning Data', 'Analyzing Data', 'Summarizing Results')
target <- c('Cleaning Data', 'Analyzing Data', 'Summarizing Results', 'Visualizing Results')
value  <- c(1,4,2,5)

links <- data.frame(source, target, value)

links2 <- merge(links,nodes,by.x = "source",by.y = "name")
#links2$source <-NULL
#names(links2) <- c("source","target","value")
links2 <- merge(links2,nodes,by.x = "target",by.y = "name")
#links2$target <- NULL
#names(links2) <- c("source","target","value")

d3Network::d3Sankey(Links = links, 
                    Nodes = nodes, 
                    Source = 'source', 
                    Target = 'target',
                    Value =  'value', 
                    NodeID = 'name',
                    nodeWidth = 3, 
                    width = 700)
})        
}