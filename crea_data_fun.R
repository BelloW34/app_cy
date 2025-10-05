####
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
        group_by(year, month) |> 
        summarise(y = n()) 
      
      if(fill){  #met un zero aux mois sans cyclones
        print("ici!i")
        dtp2 <- expand.grid(1:12, year1:year2) |> 
          rename(month = Var1, year = Var2) |> 
          select(year, month) |> 
          left_join(dtp2) |> 
          mutate(y = replace_na(y, 0))
        print("et laaa")
      }
      
    }else{
      dtp2 <- dtp |> 
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
          print("ici!i")
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
          print("et laaa")
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