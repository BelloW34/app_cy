###                               FONCTION                               #####
################################################################################


dt_var_ym <- function(var, q1 = 0.5, q2 = 0.5){
  
  # data frame année * mois
  ym <- expand.grid(1:12, 1979:2022) |> 
    rename(month = Var1, year = Var2) |> 
    select(year, month)
  
  #  data frame avec pour chaque cyclone  (ici on parle de la puissance des 
  #cyclones, si 0.5 c'est la moyen, si 0.9 c'est la puissance au plus fort, si 1 c'est la puissance max)
  
  dt_cy <- dtp |> 
    group_by(number) |> 
    summarise(year = min(year), 
              month = min(month), 
              quat_var = quantile({{var}}, q1))
  
  # Fait du data frame avec pour chaque mois * annee le quantile de l'info du dessus
  dt_ym <- dt_cy |> 
    group_by(year, month) |> 
    summarise(q_var_cy_ym  = quantile(quat_var, q2, na.rm = TRUE))
  dt_ym <- left_join(ym, dt_ym)|>
    mutate(month = factor(month.abb[month], levels = month.abb)) |>
    mutate(q_var_cy_ym = replace_na(q_var_cy_ym, 0.0001))
  
  return(dt_ym) 
}