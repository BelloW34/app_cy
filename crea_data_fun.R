#################
### crea data ###
#################
crea_data <- function(var, month_t = T, q1 = NULL, q2 = 0.5, fill = T,
                      year1 = NULL, year2 = NULL){
  
  if(is.null(year1)){year1 = 1979}
  if(is.null(year2)){year2 = 2021}
  dtp <- dtp |> 
    filter(year >= year1,
           year <= year2)
  
  #si on veux compter le nombre de cyclone par année ou année et mois
  if(var == "number") {
    if(month_t){
      dtp2 <- dtp |> 
        group_by(number) |> 
        summarise(year = min(year), 
                  month = min(month)) |> 
        group_by(year, month) |> 
        summarise(y = n())
      

      if(fill){  #met un zero aux mois sans cyclones
        dtp2 <- expand.grid(1:12, year1:year2) |> 
          rename(month = Var1, year = Var2) |> 
          select(year, month) |> 
          left_join(dtp2) |> 
          mutate(y = replace_na(y, 0))
      }
      
    }else{
      dtp2 <- dtp |> 
        group_by(number) |> 
        summarise(year = min(year))|> 
        group_by(year) |> 
        summarise(y = n())
      
    }
  } else { #variable (pas compter)
    
    if(is.null(q1)){ # si on veux la moyenne des tempetes sur toute les info de manière brute
      if(is.null(q1)){q1 = 0.5}
      if(is.null(q2)){q2 = 0.5}
      if(month_t){
        dtp2 <- dtp |> 
          group_by(year, month)|>
          summarise(y = mean(.data[[var]], na.rm = TRUE))
      }else{
        dtp2 <- dtp |> 
          group_by(year)|>
          summarise(y = mean(.data[[var]], na.rm = TRUE))
      }
      
    } else { # si on veux des info sur les tempètes
      
      dtp2 <- dtp |> 
        group_by(number) |> 
        summarise(year = min(year), 
                  month = min(month), 
                  y = quantile(.data[[var]], q1))
      
      
      if(month_t){
        dtp2 <- dtp2 |> 
          group_by(year, month) |> 
          summarise(y  = quantile(y, q2, na.rm = TRUE))
        
        if(fill){  #met un zero aux mois sans cyclones
          val_def <- 0
          if(var == "pressure"){
            val_def <- 1013.25
          }
          
          dtp2 <- expand.grid(1:12, year1:year2) |> 
            rename(month = Var1, year = Var2) |> 
            select(year, month) |> 
            left_join(dtp2) |>
            mutate(month = factor(month.abb[month], levels = month.abb)) |>
            mutate(y = replace_na(y, val_def))
        }
        
      }else{
        dtp2 <- dtp2 |> 
          group_by(year) |> 
          summarise(y  = quantile(y, q2, na.rm = TRUE))
      }
    }
  }
  return(dtp2) 
}
####

#################
### crea labs ###
#################

crea_labs <- function(var, a10 = NULL){
  labs_v <-  list(var = var, nom_var = NA, pronom = NA, unite = NA, sens = NA,
                  sous_titre = NA, labsy = NA)
  
  #1. Creation des conditions
  if(var == "vmax"){
    labs_v$nom_var = "vitesse maximale moyenne"
    labs_v$pronom = "la"
    labs_v$unite = "m/s"
  }
  else if(var == "pressure"){
    labs_v$nom_var <- "pression moyenne"
    labs_v$pronom <- "la"
    labs_v$unite <- "hPa"
  }
  else if (var == "rmax"){
    labs_v$nom_var <- "rayon maximum moyen"
    labs_v$pronom <- "le"
    labs_v$unite <- "km"
  }
  else if(var == "number"){
    labs_v$nom_var <- "nombre"
  }
  
  if(!is.null(a10)){
    if(a10 >= 0){
      labs_v$sens <- "augmente de"
    }
    else if(a10 <= 0){
      labs_v$sens <- "diminue de"
    }
    
    #2. Création du sous-titre dans le cas ou la variable number est appelée
    if(var == "number"){
      labs_v$sous_titre <- paste("Tous les 10 ans, le nombre de cyclone", 
                                 labs_v$sens, abs(a10))
    }
    
    #3. Création du sous-titre dans le cas ou une variable différente de number 
    #est appelée
    else {
      labs_v$sous_titre <- paste("Tous les 10 ans,", labs_v$pronom,
                                 labs_v$nom_var, "des cyclones", 
                                 labs_v$sens, abs(a10), labs_v$unite)
    }
  }
  
  #######
  #Création de labels des ordonnées variable en fonction de la variable choisi ##
  
  #1. Création du label dans le cas ou la variable number est appelée
  if(var == "number"){
    labs_v$labsy <- paste(labs_v$nom_var)
  }
  
  #2. Création du label dans le cas ou une variable différente de number 
  #est appelée
  else {
    labs_v$labsy <- paste(labs_v$nom_var, "en",
                          labs_v$unite)
  }
  return(labs_v)
}




