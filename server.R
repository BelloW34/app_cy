function(input, output, session) {
  
  ##############################################################################
  ######              affichage de la description dans l'intro             #####
  ##############################################################################
  
  output$desc_dtp <- renderPrint({
    summary(dtp) # Hmisc::describe() prend beaucoup de temps on peut le pré 
    #calculer
  })
  
  
  ##############################################################################
  ######                 affichage var par quantile par mois               #####
  ##############################################################################
  
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
  
  
  ##############################################################################
  ######                   affichage de la carte pacifique                 #####
  ##############################################################################
  
  output$leaflet_var <- renderLeaflet({
    varyear <- as.Date(input$choixy)
    var <- input$choixvarleaflet
    dt <- dtp %>% filter(year==varyear)
    dt <- dt %>%
      mutate(selected = as.numeric(as.character(.data[[var]])))
    vals <- dt$selected
    if (all(is.na(vals))) {
      # si tout est NA, on choisit un domaine par défaut pour éviter erreurs
      rng <- c(0, 1)
    } else {
      rng <- range(vals, na.rm = TRUE)
    }
    pal <- colorNumeric(
      palette = "viridis",  
      domain = rng   # la variable à représenter
    )
    leaflet(data = dt) %>% 
      addTiles() %>% 
      addCircleMarkers(~lon, ~lat, radius=4, color = ~pal(selected), fillOpacity = 0.8, stroke = FALSE,popup = ~paste(name,"<br><b>Année:</b>", year,
                                                                                                                      "<br><b>", var, ":</b>", selected
      )) %>% 
      addLegend("bottomright",
                pal = pal,
                values = vals,
                title = paste("Valeur de", var),
                opacity = 1
      )
    
  })
  
  
  
  ##############################################################################
  ######                        affichage fonction Thib                    #####
  ##############################################################################
  
  output$plot_varexp <- renderPlot({
    varname <- sym(input$choixvarexp)
    print(class(varname))
    print(varname)
    fun_reg_var(!!varname)
  })
  
}