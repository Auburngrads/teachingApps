
server = function(input, output, session) {

    output$armadillo_overview <- renderUI({ add_rmd('overview.Rmd')  })
     add_server('acceptance_testing_mtbf', env = environment())
    
    output$examplemtbf    <- renderUI({ add_rmd('example.Rmd')    })
    output$backgroundmtbf <- renderUI({ add_rmd('background.Rmd') })
    output$aboutmtbf      <- renderUI({ add_rmd('about.Rmd')      })
}
