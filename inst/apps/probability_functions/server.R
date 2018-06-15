server = function(input, output, session) {

output$overview <- renderUI({ add_rmd('overview.Rmd') })

output$functable <- renderUI({ add_rmd('functable.Rmd') }) 
    
output$cdfdemo <- renderUI({ add_rmd('backgroundcdf.Rmd') })
output$cdfr    <- renderUI({ add_rmd('rfuncscdf.Rmd') })  
      add_server('cdf_ace', env = environment())

output$pdfdemo <- renderUI({ add_rmd('backgroundpdf.Rmd') })
output$pdfr    <- renderUI({ add_rmd('rfuncspdf.Rmd') })  
      add_server('pdf_ace', env = environment())
      
output$reldemo <- renderUI({ add_rmd('backgroundsurv.Rmd') })
output$relr    <- renderUI({ add_rmd('rfuncssurv.Rmd') })  
      add_server('rel_ace', env = environment())
      
output$hazdemo <- renderUI({ add_rmd('backgroundhaz.Rmd') })
output$hazr    <- renderUI({ add_rmd('rfuncshaz.Rmd') })  
      add_server('haz_ace', env = environment())
      
output$chazdemo <- renderUI({ add_rmd('backgroundchaz.Rmd') })
output$chazr    <- renderUI({ add_rmd('rfuncschaz.Rmd') })  
      add_server('chaz_ace', env = environment())
      
output$quandemo <- renderUI({ add_rmd('backgroundquan.Rmd') })
output$quanr    <- renderUI({ add_rmd('rfuncsquan.Rmd') })  
      add_server('quan_ace', env = environment())
}