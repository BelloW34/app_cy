function(input, output, session) {
  
  # affichage de la description dans l'intro
  output$desc_dtp <- renderPrint({
    summary(dtp) # Hmisc::describe() prend beaucoup de temps on peut le pré calculer
  })
  
  # affichage var par mois
  output$plot_var <- renderPlot({
    varname <- sym(input$choixvar)
    dt_ym <- dt_var_ym(var = !!varname, q1 = 0.5, q2 = 0.5)
    
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
  output$leaflet_var <- renderPlot({
    varyear <- sym(input$choixy)
    var <- sym(input$choixvarleaflet)
    dt <- dtp %>% filter(year==!!varyear)
    leaflet_var <- leaflet(data = dt) %>% 
      addTiles() %>% 
      addCircleMarkers(~lon, ~lat, radius=4, color = ~pal(!!var), fillOpacity = 0.8, stroke = FALSE,popup = ~paste(name, "<br><b>Année:</b>",year, "<br><b>Vmax:</b>",!!var)) %>% 
      addLegend("bottomright",
                pal = pal,
                values = ~!!var,
                title = "Valeur de la variable",
                opacity = 1
      )
    
    return(leaflet_var)
  })
  
}