server = function(input, output, session) {

 output$mychart <- renderLineChart({
 # Return a data frame. Each column will be a series in the line chart.
   data.frame(
   Sine = sin(1:100/10 + input$sinePhase * pi/180) * input$sineAmplitude,
   Cosine = 0.5 * cos(1:100/10),
   "Sine 2" = sin(1:100/10) * 0.25 + 0.5
   )
   })
 }



 # To be called from server.R
 


 # Data frame or list looks like:
 #
 # {
 #   "Series A": [1,2,3,4,5],
 #   "Series B": [6,7,8,9,10]
 # }
 #
 # D3 expects:
 #
 # [
 #   {
 #     key: "Series A",
 #     values: [{x:1,y:1}, {x:2,y:2}, {x:3,y:3}, {x:4,y:4}, {x:5,y:5}]
#   },
 #   {
 #     key: "Series B",
 #     values: [{x:1,y:6}, {x:2,y:7}, {x:3,y:8}, {x:4,y:9}, {x:5,y:10}]
 #   }
 # ]
#  dataFrameToD3 <- function(df=cars) {
# 
# 
# }
