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
    
    labs_var <- crea_labs(input$choixvar)
    
    dt_ym <- crea_data(var = input$choixvar,
                       q1 = input$choixq2, q2 = input$choixq1)
    
    if(input$choixvar == "number"){
      y_labs <- labs_var$nom
    }else{
      y_labs <- paste(labs_var$nom, "en", labs_var$unite)
    }


      plot_var <- dt_ym |> 
        ggplot() +
        aes(x = month, y = y, group = year, colour = year) + 
        geom_smooth(se = FALSE, alpha = 0.6) +
        scale_color_viridis(option='viridis',
                            direction = -1,
                            begin = 0,
                            end = 1) +
        labs(x = "Années",
             y = y_labs,
             title = paste0("Variations mensuelles des ", 100*input$choixq1 , "% du ",
                            100*input$choixq2 , "% de ", labs_var$pronom, " ",
                            labs_var$nom)) +
        theme(axis.line = element_line(colour = "black"),
              panel.grid.major = element_blank(), #Suppression de la grille majeure
              panel.grid.minor = element_blank(), #suppression de la grille mineure
              panel.border = element_blank(), #suppression du cadre
              panel.background = element_blank(), #suppression du fond
              text = element_text(size = 15)) #augmentation de la taille des labels

    
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
      domain = rng   # la variable à représenter
    )
    if (var=="age"){
      car <- "Nombre d'heures de vie"
    }
    if (var=="pressure"){
      car <- "Valeur de la pression (hPa)"
    }
    if (var=="rmax"){
      car <- "Valeur du rayon maximal (m)"
    }
    if (var=="vmax"){
      car <- "Valeur de la vitesse maximale (km/h)"
    }
    leaflet(data = dt,options = leafletOptions(worldCopyJump = TRUE)) %>% 
      addTiles() %>% 
      addCircleMarkers(~lon, ~lat, radius=3, color = ~pal(selected), fillOpacity = 0.8, stroke = FALSE,popup = ~paste(name,"<br><b>Année:</b>", year,"<br><b>vmax:</b>", round(vmax, digits=2),"km/h","<br><b>rmax:</b>", round(rmax, digits=2),"km", "<br><b>Pression:</b>", round(pressure, digits=2),"hPa","<br><b>Durée de vie:</b>", age_n)) %>% 
      addLegend("bottomright",
                pal = pal,
                values = vals,
                title = paste(car),
                opacity = 1) %>%
      addScaleBar() %>% 
      setView(lng = -150, lat = 0, zoom = 2)
  })
  
  
  ##############################################################################
  ######                     affichage fonction de regression              #####
  ##############################################################################
  
  output$plot_varexp <- renderPlot({
    
    #Fonction pour la régression des valeurs moyennes annuelles par variable
    #####
    fun_reg_var <- function(var){
      
      #######
      #Transformations des données #################################################
      
      #Situation 1. Appel de la variable number => Calcul du nombre de cyclones par 
      #ans
      #Situation 2. Appel d'une autre variable => Calcul de la moyenne de la variable
      #par ans
      dtp2 <- crea_data(var, month_t = F)
      
      #Modèle linéaire simple ######################################################
      
      #1. Ajustement
      m <- lm(y ~ year, 
              data = dtp2)
      
      #2. Extraction des paramètres
      coef <- round(coefficients(m), 2)
      
      #3. Multiplication de beta1 par 10 pour obtenir des variations de la variable 
      #sur 10 ans
      a10 <- coef[2]*10
      
      #######
      #Création d'un sous-titre variable en fonction de la variable choisi #########
      
      labs_v <- crea_labs(var, a10)
      
      #######
      #Réalisation du graphique brut ################################################
      plot <- dtp2 |> 
        ggplot()+
        aes(x = year, y = y)+
        geom_smooth(method = lm, colour = "blue", fill = "lightskyblue")+
        geom_line()+
        
        #Appel des labels variable en fonction des variables choisi
        labs(x = "Années", y = labs_v$labsy, caption = labs_v$sous_titre)+
        
        #######
      #Modification du theme #######################################################
      theme(axis.line = element_line(colour = "black"),
            panel.grid.major = element_blank(), #Suppression de la grille majeure
            panel.grid.minor = element_blank(), #suppression de la grille mineure
            panel.border = element_blank(), #suppression du cadre
            panel.background = element_blank(), #suppression du fond
            text = element_text(size = 18)) #augmentation de la taille du texte
      
      #Appel du graphique comme sortie de la fonction ##############################
      return(plot)
    }
    #####
    
    fun_reg_var(input$choixvarexp)
  })
  
  ##############################################################################
  ######                        affichage fonction land                    #####
  ##############################################################################
  
  output$plot_land <- renderPlot({
    dt_py <- dtp %>% group_by(year) %>% summarise (pland=mean(land=="TRUE")*100)
    dt_py %>% ggplot(aes(x=as.numeric(year), y=pland))+
      geom_col(fill="steelblue",alpha=0.5) +
      geom_smooth(method = "lm",colour = "blue", fill = "lightskyblue") +
      scale_x_continuous(breaks=seq(min(dt_py$year),max(dt_py$year),by=5)) +
      labs(x="Années", y="Pourcentage de cyclones ayant touchés la terre")  +
      theme(axis.line = element_line(colour = "black"),
            panel.grid.major = element_blank(), #Suppression de la grille majeure
            panel.grid.minor = element_blank(), #suppression de la grille mineure
            panel.border = element_blank(), #suppression du cadre
            panel.background = element_blank(), #suppression du fond
            text = element_text(size = 15))
  })
  
}