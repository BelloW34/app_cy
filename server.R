function(input, output, session) {
  
  output$plot_var <- renderPlot({
    varname <- sym(input$choixvar)
    dt_ym <- dt_var_ym(var = !!varname,q1 = 0.5,q2 = 0.5)
    
    plot_var <- dt_ym |> 
      ggplot() +
      aes(x = month, y = q_var_cy_ym, group = year, colour = year) + 
      geom_smooth(se = FALSE, alpha = 0.6) +
      scale_color_viridis(option='magma',
                          direction = -1,
                          begin = 0,
                          end = 1) +
      theme_classic()
    
    return(plot_var)
  })
  
}