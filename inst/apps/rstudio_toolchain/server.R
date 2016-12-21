server = function(input, output, session) {

  install_rw <- HTML({ })
  
output$r_windows_p  <- renderUI({ install_rw })
output$rs_windows_p <- renderUI({HTML( ) })
output$rt_windows_p <- renderUI({HTML( ) })
output$l_windows_p  <- renderUI({HTML( ) })
output$g_windows_p  <- renderUI({HTML( ) })

output$r_windows_a  <- renderUI({HTML( )})
output$rs_windows_a <- renderUI({HTML( ) })
output$rt_windows_a <- renderUI({ })
output$l_windows_a  <- renderUI({ withMathJax(HTML('')) })
output$g_windows_a  <- renderUI({HTML( ) })

output$r_mac  <- renderUI({ install_rw })
output$rs_mac <- renderUI({HTML( ) })
output$rt_mac <- renderUI({HTML( ) })
output$l_mac  <- renderUI({HTML( ) })
output$g_mac  <- renderUI({HTML( ) })
  
output$r_linux  <- renderUI({ install_rw })
output$rs_linux <- renderUI({HTML( ) })
output$rt_linux <- renderUI({HTML( ) })
output$l_linux  <- renderUI({HTML( ) })
output$g_linux  <- renderUI({HTML( ) })

output$r_unix  <- renderUI({ install_rw })
output$rs_unix <- renderUI({HTML( ) })
output$rt_unix <- renderUI({HTML( ) })
output$l_unix  <- renderUI({HTML( ) })
output$g_unix  <- renderUI({HTML( ) })
}