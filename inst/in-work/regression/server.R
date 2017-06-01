server <- function(input, output) {
  
output$reduced <- renderUI({
  
  response.col <- which(colnames(map_data)%in%input$response)
  
  selectInput('factor',
              label = 'Select Factor',
              choices = colnames(map_data)[-c(1,response.col)],
              selected = colnames(map_data)[4])
})
  
response.col <- reactive(which(colnames(map_data)%in%input$response))
factor.col   <- reactive(which(colnames(map_data)%in%input$factor))

output$plot <- renderPlot({ 
  
   #response.col <- which(colnames(map_data)%in%input$response)
   #factor.col   <- which(colnames(map_data)%in%input$factor)

     model <- lm(data = map_data, 
                 formula = map_data[,response.col()]~map_data[,factor.col()])
  plot(model , which = 1)
})

output$summary <- renderPrint({ 
  
   #response.col <- which(colnames(map_data)%in%input$response)
   #factor.col   <- which(colnames(map_data)%in%input$factor)

   model <- lm(data = map_data, 
              formula = map_data[,response.col()]~map_data[,factor.col()])
   
  summary(model)
})

output$table <- renderTable({ 
  
   #response.col <- which(colnames(map_data)%in%input$response)
   #factor.col   <- which(colnames(map_data)%in%input$factor)

   model <- lm(data = map_data, 
               formula = map_data[,response.col()]~map_data[,factor.col()])
   
  as.data.frame(summary(model)$coeff,
                row.names = c('Intercept',colnames(map_data)[factor.col()]))
  }, rownames = T)
  
}
