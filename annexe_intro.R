texte_into <- list(para1 = tagList(
  h2("Comment ont évolué les caractéristiques des cyclones dans le Pacifique entre 1979 et 2022 ?"),
  
  p(strong("Informations sur les données :")),
  p("les données sont issues de Xu et al., 2024 
    (https://doi.org/10.5194/essd-2024-329). Il s'agit de données décrivant la 
    taille et l'intensité des cyclones tropicaux (TC) à l'échelle mondiale entre
    1959 à 2022, avec une résolution temporelle de 3 heures. Les données 
    proviennent d'une fusion des données IBTrACS (International Best Track 
    Archive for Climate Stewardship) et ERA5 (European Centre for MediumRange 
    Weather Forecasts Reanalysis 5)"),
  
  p(strong("Explication des colonnes du jeu de données:")),
  p("- numéro : indice du TC (issu des données IBTrACS)"),
  p("- nom : nom du TC (issu des données IBTrACS)"),
  p("- année : année du TC (issu des données IBTrACS)"),
  p("- mois : mois du TC (issu des données IBTrACS)"),
  p("- jour : jour du TC (issu des données IBTrACS)"),
  p("- heure : heure du TC (issu des données IBTrACS)"),
  p("- nature : nature du TC (issu des données IBTrACS) avec :"),
  p("    DS : Perturbation"),
  p("    ET : Cyclone extratropical"),
  p("    MX : Nature incertaine"),
  p("    NR : Nature non rapporté"),
  p("    ST : Cyclone subtropical"),
  p("    TS : Cyclone tropical"),
  p("- lat : latitude (issu des données IBTrACS)"),
  p("- lon : longitude (issu des données IBTrACS)"),
  p("- terre : Bouléen indiquant si un TC a touché terre"),
  p("- vmax : Vitesse maximale du vent (noeuds.s-1)"),
  p("- pression : Pression minimum au centre du CT"),
  p("rmax : Distance entre la zone de plus basse pression au centre du CT et
    la bande ou les vents atteignent leur vitesse maximale"),
  p("-R34 : distances depuis le centre du cyclone jusqu'a la zone où la vitesse 
    des vents atteind 34 nœuds."),
  p("-R50 : distances depuis le centre du cyclone jusqu'a la zone où la vitesse 
    des vents atteind 50 nœuds."),
  p("-R64 : distances depuis le centre du cyclone jusqu'a la zone où la vitesse 
    des vents atteind 64 nœuds."),
  
  p(strong("Problématisation :")),
  p("Les cyclones tropicaux sont des phénomènes météorologiques pouvant être 
    dévastateurs pour les installations humaines. Le dérèglement climatique en 
    cours perturbe les mécanismes à l'origine de ces cyclones et donc leurs 
    caractéristiques au cours du temps. Ainsi, la compréhenssion de l'évolution 
    des caractéristiques des cyclones est nécessaire pour protéger les 
    populations des risques issus de ces cyclones en contexte de changements 
    climatiques. Nous proposons donc ici de montrer l'évolution au cours du temps des 
    caractéristiques des cyclones. Ces caractéristiques seront plus précisémment 
    la vitesse maximale des vents (vmax), la pression au centre du cyclone (pressure),
    le rayon des vents maximum (rmax) et le nombre de cyclones. Ceci sera montré 
    a travers une application destiné à de la médiation scientifique"),
  
  p(strong("Modifications apportées aux données :")),
  p("Avant 1979 les détections de cyclone ne se faisiant pas par satellite 
    (Xu et al., 2024), ce qui implique que certains d'entre eux n'ont peut être 
    jamais été enregistré dans les données. Nous ferons donc nos analyses 
    (notamment de fréquence) à partir de 1979 pour éviter un biais 
    d'échantillonnage."),
  p("Les colonnes R34, R50 et R64 montrent beacoup de données manquantes et la 
    variable Rmax donne des informations similaires. Les colonnes R34, R50 et R64
    ne seront donc non utilisées ici.")
)
)

