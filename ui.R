#
header <- dashboardHeader(title = "Cyclones du Pacifique")

################################################################################
#####                                 Side                                 #####
################################################################################

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Présentation", tabName = "presentation"),
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
            texte_into_1$para1,
            img(src = "schema_cyclone.jpg", height = "500px", width = "800px"),
            texte_into_2$para1,
            texte_into_3$para1,
            verbatimTextOutput("desc_dtp")
    ),
    
    ######################## Carte ########################
    tabItem(tabName = "carte", h2("Carte du Pacifique"),
            texte_page_2$para1,
            radioButtons("choixvarleaflet", "Choisissez la variable d'étude :",
                         choices = list("Vmax" = "vmax", "Rmax" = "rmax", "Pression"="pressure", "Heures de vie"="age"),
                         selected = "vmax"),
            radioButtons("choixpa","Choisissez sur une période ou sur une année :", 
                         choices=list("Année"="annee", "Période"="periode"),
                         selected="annee"),
            conditionalPanel(condition="input.choixpa == 'annee'",sliderInput("choixy","Date",min = 1979,max = 2021,value = 1979)),
            conditionalPanel(condition="input.choixpa == 'periode'", sliderInput("choixp","Période",min = 1979, max = 2021, value =c(1979,1980))),
            leafletOutput("leaflet_var")),
    
    #################  ANALYSE de DONNEE #################
    tabItem(tabName = "analyse",
            
            navset_tab(
              nav_panel("Variations mensuelles pluriannuelles",
                        texte_page_3A$para1,
                        radioButtons("choixvar", "Choisissez la variable d'étude :",
                                     choices = list("Vitesse maximale" = "vmax", "Rayon maximal" = "rmax", "Pression"="pressure", "Nombre de cyclone" = "number"),
                                     selected = "vmax"
                        ),
                        sliderInput("choixq1","Choisissez la valeur de q1:",min = 0,max = 1, value = 0.9),
                        sliderInput("choixq2","Choisissez la valeur de q2:",min = 0,max = 1, value = 0.9),
                        plotOutput("plot_var")
              ),
              
              nav_panel("Régressions",
                        texte_page_3B$para1,
                        radioButtons("choixvarexp", "Choisissez la variable d'étude :",
                                     choices = list("Vitesse maximale" = "vmax", "Rayon maximal" = "rmax", "Pression"="pressure", "Nombre de cyclone" = "number"),
                                     selected = "vmax"),
                        plotOutput("plot_varexp"),
              ),
              
              nav_panel("Correlation",
                        texte_page_3C$para1,
                        img(src = "corrplot.png", height = "500px", width = "500px")
              )
              
            )
    ),
    
    
    
    
    
    
    
    
    ############### Conclusion ##############
    tabItem(tabName = "conclusion",
            texte_page_conclusion$para1, 
            plotOutput("plot_land"))
  )
)

################################################################################
#####                                Liaison                               #####
################################################################################

dashboardPage(header,sidebar,body)
