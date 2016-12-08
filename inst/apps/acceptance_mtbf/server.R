
server = function(input, output, session) {

teachingApps::insertServer('acceptance_testing_mtbf', envir = environment())
    output$howtomtbf      <- renderUI({ insertRmd('howtomtbf.Rmd')  })
    output$examplemtbf    <- renderUI({ insertRmd('example.Rmd')    })
    output$backgroundmtbf <- renderUI({ insertRmd('background.Rmd') })
    output$aboutmtbf      <- renderUI({ insertRmd('about.Rmd')      })
}
