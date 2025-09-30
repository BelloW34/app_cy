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
    tabItem(tabName = "presentation", 
            texte_into$para1, 
            verbatimTextOutput("desc_dtp"),
            texte_into$para2
    ),
    ############################################################################
    #####                      Exploration des Données                     #####
    ############################################################################
    tabItem(tabName = "exploration",
            radioButtons("choixvarexp", "Choisissez la variable d'étude :",
                         choices = list("Vmax" = "vmax", "Rmax" = "rmax", "Pression"="pressure"),
                         selected = "vmax"),
            plotOutput("plot_varexp")),
    
    
    ######################## Carte ########################
    tabItem(tabName = "carte", h2("Carte du Pacifique"),
            radioButtons("choixvarleaflet", "Choisissez la variable d'étude :",
                         choices = list("Vmax" = "vmax", "Rmax" = "rmax", "Pression"="pressure"),
                         selected = "vmax"),
            numericInput("choixy", "date après 1979", value = 1979),
            leafletOutput("leaflet_var")),
    
    #################  ANALYSE de DONNEE #################
    tabItem(tabName = "analyse",
            radioButtons("choixvar", "Choisissez la variable d'étude :",
                         choices = list("Vmax" = "vmax", "Rmax" = "rmax", "Pression"="pressure"),
                         selected = "vmax"
            ),
            sliderInput("choixq1","Choisissez la valeur de q1:",min = 0,max = 1, value = 10),
            sliderInput("choixq2","Choisissez la valeur de q2:",min = 0,max = 1, value = 10),
            plotOutput("plot_var")),
    
    ############### Conclusion ##############
    tabItem(tabName = "conclusion")
  )
)

################################################################################
#####                                Liaison                               #####
################################################################################

dashboardPage(header,sidebar,body)
