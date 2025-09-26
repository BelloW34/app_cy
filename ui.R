#
header <- dashboardHeader(title = "Cyclones du Pacifique")

################################################################################
#####                                 Side                                 #####
################################################################################

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Présentation", tabName = "presentation"),
    menuItem("Exploration des données", tabName = "exploration",  icon = icon("database")),
    menuItem("Carte Interactive", tabName = "carte", icon = icon("map")),
    menuItem("Analyse de Données", tabName = "analyse", icon = icon("chart-bar")),
    menuItem("Conclusion", tabName="conclusion")
  )
)


################################################################################
#####                                Corps                                 #####
################################################################################

body <- dashboardBody(
  tabItems(    
    ######################## Presentation ######################## 
    tabItem(tabName = "presentation", h2("Comment ont évolué les caractéristiques des cyclones dans le Pacifique entre 1979 et 2022 ?"),
            p(strong("Informations sur les données :")),
            p("les données sont issues de Xu et al., 2024 (https://doi.org/10.5194/essd-2024-329). Il s'agit de données décrivant la taille et l'intensité des cyclones tropicaux (TC) à l'échelle mondiale entre 1959 à 2022, avec une résolution temporelle de 3 heures. Les données proviennent d'une fusion des données IBTrACS (International Best Track Archive for Climate Stewardship) et ERA5 (European Centre for MediumRange Weather Forecasts Reanalysis 5), enrichies de 2 variables :

-Le rayon du vent maximal (RMW), qui est la distance entre le centre du cyclone et la bande ou se trouve les vents les plus forts. 

-La pression minimale au centre du TC.
ctions de cyclone ne se faisiant pas par satellite (Xu et al., 2024), ce qui implique que certains d'entre eux n'ont peut être jamais été enregistré dans les données. Nous ferons donc nos analyses (notamment de fréquence) à partir de 1979 pour éviter un biais d'échantillonnage.
R34, R50 et R64 avec beacoup de NA donc non utilisées ici. "),
            
            p(strong("Explication des colonnes :")),
            p("-numéro : indice du TC (issu des données IBTrACS)
-nom : nom du TC (issu des données IBTrACS)
-année : année du TC (issu des données IBTrACS)
-mois : mois du TC (issu des données IBTrACS)
-jour : jour du TC (issu des données IBTrACS)
-heure : heure du TC (issu des données IBTrACS)
-nature : nature du TC (issu des données IBTrACS) avec :


-Les diamètres de TC (R).
              Avant 1979 les déte DS : Perturbation
  ET : Extratropical
  MX : Mélange ou rapports contradictoires de nature provenant de différentes agences
  NR : Non rapporté
  ST : Subtropical
  TS : Tropical
-lat : latitude du TC (issu des données IBTrACS)
-lon : longitude du TC (issu des données IBTrACS)
-terre : indique si un TC a touché terre
-vmax : la vitesse maximale du vent (m.s-1), dérivée par des modèles de forêts aléatoires avec les profils de vent azimutaux moyens à 10 m issus des données ERA5 comme entrée, et la vitesse maximale du vent des données IBTrACS comme données d'apprentissage
-pression : la pression centrale minimale, dérivée par un modèle empirique de la relation vent-pression
-rmax : RMW est dérivé par des modèles de forêts aléatoires avec les profils de vent azimutaux moyens à 10 m dérivés de l'ERA5 comme entrée, et le rayon du vent maximal de l'IBTrACS comme cible d'apprentissage
-R34 : distances depuis le centre du cyclone jusqu'a la zone où la vitesse du vent atteind 34 nœuds.
-R50 : distances depuis le centre du cyclone jusqu'a la zone où la vitesse du vent atteind 50 nœuds.
-R64 : distances depuis le centre du cyclone jusqu'a la zone où la vitesse du vent atteind 64 nœuds."),
            
            p(strong("Problématisation :")),
            p("Les cyclones tropicaux sont des phénomènes météorologiques pouvant être dévastateurs pour les installations humaines. Le dérèglement climatique en cours perturbe les mécanismes à l'origine de ces cyclones et donc leurs caractéristiques au cours du temps. Ainsi, la compréhenssion de l'évolution des caractéristiques des cyclones est nécessaire pour protéger les populations des risques issus de ces cyclones en contexte de changements climatiques. Nous proposons donc ici l'évolution au cours du temps des caractéristiques des cyclones. Ceci sera montré a travers une application destiné à de la médiation scientifique. 
")
            
            
            
            
    ),
    ############################################################################
    #####                      Exploration des Données                     #####
    ############################################################################
    
    tabItem(tabName = "exploration"),
    
    ############################################################################
    #####                              Carte                               #####
    ############################################################################
    ######################## Carte ########################
    tabItem(tabName = "carte", h2("Carte du Pacifique")),
    
    ############################################################################
    #####                      ANALYSE de DONNEE                           #####
    ############################################################################
    tabItem(tabName = "analyse",
            radioButtons("choixvar", "Choisissez la variable d'étude :",
                         choices = list("Vmax" = "vmax", "Rmax" = "rmax", "Pression"="pressure"),
                         selected = "vmax"
            ),
            plotOutput("plot_var")),
    
    ############################################################################
    #####                             Conclusion                           #####
    ############################################################################
    tabItem(tabName = "conclusion")
  )
)

################################################################################
#####                                Liaison                               #####
################################################################################

dashboardPage(header,sidebar,body)
