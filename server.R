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
    var <- input$choixvarleaflet
    if (input$choixpa=="annee"){
      varyear <- as.Date(input$choixy)
      dt <- dtp %>% filter(year==varyear)
    } else {
      varyear1 <- as.Date(input$choixp[1])
      varyear2 <- as.Date(input$choixp[2])
      dt <- dtp %>% filter(varyear1<=year & year<=varyear2)
    }
    dt <- dt %>%
      mutate(selected = as.numeric(as.character(.data[[var]])))
    vals <- dt$selected
    dt_wrap <- dt
    dt_wrap$lon <- ifelse(dt$lon < 0, dt$lon + 360, dt$lon - 360)
    dt <- rbind(dt, dt_wrap)
    if (all(is.na(vals))) {
      # si tout est NA, on choisit un domaine par défaut pour éviter erreurs
      rng <- c(0, 1)
    } else {
      rng <- range(vals, na.rm = TRUE)
    }
    pal <- colorNumeric(
      palette = "viridis",  
      domain = rng   
    )
    leaflet(data = dt,options = leafletOptions(worldCopyJump = TRUE)) %>% 
      addTiles() %>% 
      addCircleMarkers(~lon, ~lat, radius=3, color = ~pal(selected), fillOpacity = 0.8, stroke = FALSE,popup = ~paste(name,"<br><b>Année:</b>", year,"<br><b>vmax:</b>", round(vmax, digits=2),"m.s-1","<br><b>rmax:</b>", round(rmax, digits=2),"m", "<br><b>Pression:</b>", round(pressure, digits=2),"Pa","<br><b>Durée de vie:</b>", age_n)) %>% 
      addLegend("bottomright",
                pal = pal,
                values = vals,
                title = paste("Valeur de", var),
                opacity = 1) %>%
      addScaleBar() %>% 
      setView(lng = -150, lat = 0, zoom = 2)
  })
  
  
  
  ##############################################################################
  ######                        affichage fonction Thib                    #####
  ##############################################################################
  
  output$plot_varexp <- renderPlot({
    fun_reg_var(input$choixvarexp)
  })
  
}