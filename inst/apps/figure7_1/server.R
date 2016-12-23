server = function(input, output, session) {
  
output$berkson <- renderPlot({

  par(family="serif",font=2)

berkson <- switch(input$n7.1, 
                  "20" = {SMRD::berkson20},
                  "200" = {SMRD::berkson200},
                  "2000" = {SMRD::berkson2000},
                  "10220" = {SMRD::berkson10220})

berkson.ld <- frame.to.ld(berkson,
                          response.column = c(1,2),
                          censor.column = 3,
                          case.weight.column = 4)

plot(berkson.ld, distribution = "Exponential", band.type = "Simultaneous")  
})
  
output$table.1 <- DT::renderDataTable({ 
  
L <- c(0,100,300,500,700,1000,2000,4000)
U <- c(100,300,500,700,1000,2000,4000,10)
n.10220 <- c(1609, 2424,1770,1306,1213,1528,354,16)
n.2000 <- c(292,494,332,236,261,308,73,4)
n.200 <- c(41,44,24,32,29,21,9,0)
n.20 <- c(3,7,4,1,3,2,0,0)
table.7.1 <- data.frame(L,U,n.10220,n.2000,n.200,n.20)

colnames(table.7.1) <- c("Lower","Upper","n = 10220","n = 2000","n = 200","n = 20")

DT::datatable(table.7.1, options = list(pageLength = 10))
  
})

output$cm.table.1 <- codemirrorR::renderCodemirror({codemirrorR::codemirror(mode = 'r',
"
## R code to produce various types of tables

## Coerce the Table 7.1 information into a data.frame named `table.7.1`

L <- c(0,100,300,500,700,1000,2000,4000)
U <- c(100,300,500,700,1000,2000,4000,10)
n.10220 <- c(1609, 2424,1770,1306,1213,1528,354,16)
n.2000 <- c(292,494,332,236,261,308,73,4)
n.200 <- c(41,44,24,32,29,21,9,0)
n.20 <- c(3,7,4,1,3,2,0,0)
table.7.1 < -data.frame(L,U,n.10220,n.2000,n.200,n.20)
colnames(table.7.1) <- c('Lower','Upper','n = 10220','n = 2000','n = 200','n = 20')

## Coerce `table.7.1` into an interactive data table using the DT package

DT::datatable(table.7.1)

## Coerce `table.7.1` into a static HTML table using the pander package

pander::pandoc.table(table.7.1, style = 'rmarkdown')

## Coerce `table.7.1` into a static LaTeX table using the xtable package

xtable::xtable(table.7.1)")
})
}