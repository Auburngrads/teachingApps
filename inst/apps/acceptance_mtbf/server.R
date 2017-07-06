
server = function(input, output, session) {

     add_server('acceptance_testing_mtbf', env = environment())
    output$howtomtbf      <- renderUI({ add_rmd('howtomtbf.Rmd')  })
    output$examplemtbf    <- renderUI({ add_rmd('example.Rmd')    })
    output$backgroundmtbf <- renderUI({ add_rmd('background.Rmd') })
    output$aboutmtbf      <- renderUI({ add_rmd('about.Rmd')      })
}
