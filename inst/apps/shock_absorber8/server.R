server = function(input, output, session) {
  
output$summary.shock <- 
  renderPrint({ summary(ShockAbsorber.ld) 
})

output$table.shock <-    
  DT::renderDataTable({DT::datatable(ShockAbsorber.ld,
                                   options = list(pageLength = 10)) 
})

output$eventplot.shock <- 
  renderPlot({ 
  if (input$PLOT_3 == "Event Plot") 
    event.plot(ShockAbsorber.ld) 
    
  if (input$PLOT_3 == "Histogram")  
    hist(Response(ShockAbsorber.ld), 
         probability = TRUE, 
         col = 1, 
         border = "white", 
         main = "", 
         xlab = attr(ShockAbsorber.ld,"time.units"))
})

output$cdfplot.shock <- 
  renderPlot({ 
  plot(ShockAbsorber.ld, 
       distribution = input$DIST_3, 
       conf.level = as.numeric(input$CI_3), 
       band.type = input$BT_3) 
})

output$mleplot <- 
  renderPlot({ 
  if (input$mleplot == "CDF Plot") 
    mleprobplot(ShockAbsorber.ld, 
                distribution = input$mledist, 
                param.loc = input$paramloc ) 
    
  if (input$mleplot == "Hazard Plot") 
    mlehazplot(ShockAbsorber.ld, 
               distribution = input$mledist,
               param.loc = input$paramloc)
    
  if (input$mleplot == "Compare CDF Plots") 
    compare.mleprobplot(ShockAbsorber.ld, 
                        main.distribution = input$mledist, 
                        compare.distribution = input$mlecomp) 
})

output$mlemirror <-
  codemirrorR::renderCodemirror({codemirrorR::codemirror(mode = 'r', doc = "
## The only new function in this app is `compare.mleprobplot( )`
## This function is used to compare best-fit members of two or more
## distribution families
##
## The code used in this app to compare distributions is shown below
## Note that the compare.dictribution argument will accept a vector of
## multiple distributions.

ShockAbsorber.ld <- frame.to.ld(SMRD::shockabsorber,
                                response.column = 1, 
                                censor.column = 3,
                                data.title = 'Shock Absorber Data (Both Failure Modes)',
                                time.units = 'Kilometers')

compare.mleprobplot(ShockAbsorber.ld, 
                    main.distribution = 'lognormal', 
                    compare.distribution = c('Weibull'), 
                    band.type = 'pointwise')

                                                         ")
})
}