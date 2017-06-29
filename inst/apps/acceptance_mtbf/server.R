
server = function(input, output, session) {

teachingApps::add_server('acceptance_testing_mtbf', envir = environment())
    output$howtomtbf      <- renderUI({ add_rmd('howtomtbf.Rmd')  })
    output$examplemtbf    <- renderUI({ add_rmd('example.Rmd')    })
    output$backgroundmtbf <- renderUI({ add_rmd('background.Rmd') })
    output$aboutmtbf      <- renderUI({ add_rmd('about.Rmd')      })
}
