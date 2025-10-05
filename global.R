################################################################################
#####                               PACKAGE                                #####
################################################################################

library(shiny)
library(shinydashboard)
library(readr)
library(tidyverse)
library(FactoMineR)
library(RColorBrewer)
library(viridis)
library(Hmisc)
library(leaflet)
library(tidygeocoder)


################################################################################
#####                                 DATA                                 #####
################################################################################

EP <- read_csv("Eastern_Pacific.csv")
SP <- read_csv("South_Pacific.csv")
WP <- read_csv("Western_Pacific.csv")

dtp <- bind_rows(EP, SP, WP) |> 
  select(-c(Nb, R34, R50, R64, ...1)) |> 
  filter(nature == "TS",
         year >= 1979,
         year <=2021) |> 
  group_by(number)  |>          # un cyclone = un groupe
  arrange(year, month, day, hour) |>
  mutate(
    age = (row_number() - 1) * 3,
    age_n = paste0(age %/% 24, "j", age - age %/% 24, "h")
  ) |>
  ungroup() 

rm(EP,SP,WP)


################################################################################
#####                                 INTRO                                #####
################################################################################

source("annexe_intro.R")


################################################################################
#####                               FONCTION                               #####
################################################################################

source("crea_data_fun.R")





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
  
  
  
  #1. Creation des conditions
  if(var == "vmax"){
    nom_var = "vitesse maximale moyenne"
    pronom = "la"
    unite = "km/h"
  }
  else if(var == "pressure"){
    nom_var <- "pression moyenne"
    pronom <- "la"
    unite <- "hPa"
  }
  else if (var == "rmax"){
    nom_var <- "rayon maximum moyen"
    pronom <- "le"
    unite <- "m"
  }
  else if(var == "number"){
    nom_var <- "nombre"
  }
  if(a10 >= 0){
    sens <- "augmente de"
  }
  else if(a10 <= 0){
    sens <- "diminue de"
  }
  
  #2. Création du sous-titre dans le cas ou la variable number est appelée
  if(var == "number"){
    sous_titre <- paste("En moyenne, il y a", abs(a10), 
                        "cyclones de plus tous les 10 ans", sep = " ")
  }
  
  #3. Création du sous-titre dans le cas ou une variable différente de number 
  #est appelée
  else {
    sous_titre <- paste("Tous les 10 ans,", pronom, nom_var, "des cyclones", 
                        sens, abs(a10), unite, sep = " ")
  }
  
  #######
  #Création de labels des ordonnées variable en fonction de la variable choisi ##
  
  #1. Création du label dans le cas ou la variable number est appelée
  if(var == "number"){
    labsy <- paste(str_to_sentence(nom_var))
  }
  
  #2. Création du label dans le cas ou une variable différente de number 
  #est appelée
  else {
    labsy <- paste(str_to_sentence(nom_var), "en", unite, sep = " ")
  }
  
  
  #######
  #Réalisation du graphique brut ################################################
  plot <- dtp2 |> 
    ggplot()+
    aes(x = year, y = y)+
    geom_smooth(method = lm, colour = "lightskyblue4", fill = "lightskyblue")+
    geom_line()+
    
    #Appel des labels variable en fonction des variables choisi
    labs(x = "Années", y = labsy, caption = sous_titre)+
    
    #######
  #Modification du theme #######################################################
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(), #Suppression de la grille majeure
        panel.grid.minor = element_blank(), #suppression de la grille mineure
        panel.border = element_blank(), #suppression du cadre
        panel.background = element_blank(), #suppression du fond
        text = element_text(size = 15)) #augmentation de la taille des labels
  
  #Appel du graphique comme sortie de la fonction ##############################
  return(plot)
}
#####