################################################################################
#####                               PACKAGE                                #####
################################################################################

library(shiny)
library(shinydashboard)
library(bslib)
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
    age_n = paste0(age %/% 24, "j", age - 24 * (age %/% 24), "h")
  ) |>
  ungroup() 

rm(EP,SP,WP)


################################################################################
#####                                 INTRO                                #####
################################################################################

source("annexe.R")


################################################################################
#####                               FONCTION                               #####
################################################################################

source("crea_data_fun.R")




