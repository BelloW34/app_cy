texte_into_1 <- list(para1 = tagList(
  h2("Comment ont évolué les caractéristiques des cyclones dans le Pacifique entre 1979 et 2021 ?"),
  
  p(strong("Informations sur les données :")),
  p("les données sont issues de Xu et al., 2024 
    (https://doi.org/10.5194/essd-2024-329). Il s'agit de données décrivant 
    des cyclones à l'échelle mondiale entre 1959 à 2022, avec une résolution 
    temporelle de 3 heures. Les données proviennent d'une fusion des données 
    IBTrACS (International Best Track Archive for Climate Stewardship) et ERA5 
    (European Centre for MediumRange Weather Forecasts Reanalysis 5)"),
  
  p(strong("Qu'est-ce qu'un cyclone :")),
  p("Les cyclones sont des phénomènes météorologiques caractérisés par de fortes
    rafales de vent et de fortes précipitaions. L'énergie de ces phénomènes est 
    issue de la chaleur accumulée dans les eaux de surface des océans. Cette 
    chaleur des eaux de surface permet une forte évaporation et un échauffement 
    de la masse d'air susjacente. Il en résulte la formation d'une forte 
    élévation d'air chaud et humide, créant une baisse locale de la pression 
    atmosphérique par rapport à la masse d'air environnante. Ce gradient de 
    pression permet une forte aspiration d'air a la base du cyclone, formant des
    vents puissants. Grace à la déviation de Coriolis, les vents vont être 
    déviés et entrer en rotation. Cette rotation est antihoraire dans 
    l'hémisphère nord et horaire dans l'hémisphère sud. "),
)
)

texte_into_2 <- list(para1 = tagList(
  p("Schéma montrant le fonctionnement d'un cyclone"),
)
)

texte_into_3 <- list(para1 = tagList(
  p(strong("Problématisation :")),
  p("Les cyclones sont des phénomènes météorologiques pouvant être dévastateurs 
    pour les installations humaines. Le dérèglement climatique en cours perturbe 
    les mécanismes à l'origine de ces cyclones. Ceci change donc les 
    caractéristiques de ces phénomènes météorologiques au cours du temps. Ainsi, 
    la compréhension de l'évolution des caractéristiques des cyclones est 
    nécessaire pour protéger les populations des risques issus de ces aléas en 
    contexte de changements climatiques. Ainsi, Nous proposons donc ici de
    montrer l'évolution au cours du temps des caractéristiques des cyclones. 
    Ces dernières seront plus précisémment la vitesse maximale des vents (vmax), 
    la pression au centre du cyclone (pressure), le rayon des vents maximum 
    (rmax) et le nombre de cyclones. Ceci sera montré a travers une application 
    destiné à de la médiation scientifique"),
  
  
  p(strong("Explication des colonnes du jeu de données:")),
  p("- numéro : indice du cyclone (issu des données IBTrACS)"),
  p("- nom : nom du cyclone (issu des données IBTrACS)"),
  p("- année : année du cyclone (issu des données IBTrACS)"),
  p("- mois : mois du cyclone (issu des données IBTrACS)"),
  p("- jour : jour du cyclone (issu des données IBTrACS)"),
  p("- heure : heure du cyclone (issu des données IBTrACS)"),
  p("- nature : nature du cyclone (issu des données IBTrACS) avec :"),
  p("    > DS : Perturbation"),
  p("    > ET : Cyclone extratropical"),
  p("    > MX : Nature incertaine"),
  p("    > NR : Nature non rapporté"),
  p("    > ST : Cyclone subtropical"),
  p("    > TS : Cyclone tropical"),
  p("- lat : latitude (issu des données IBTrACS)"),
  p("- lon : longitude (issu des données IBTrACS)"),
  p("- terre : Bouléen indiquant si un cyclone a touché terre"),
  p("- vmax : Vitesse maximale des vents en m.s-1 modélisée"),
  p("- pression : Pression minimum au centre du cyclone modélisé"),
  p("- rmax : Distance entre la zone de plus basse pression au centre du cyclone et
    la bande ou les vents atteignent leur vitesse maximale en km modélisé"),
  p("- R34 : distances depuis le centre du cyclone jusqu'a la zone où la vitesse 
    des vents atteind 34 nœuds en km modélisé"),
  p("- R50 : distances depuis le centre du cyclone jusqu'a la zone où la vitesse 
    des vents atteind 50 nœuds en km modélisé"),
  p("- R64 : distances depuis le centre du cyclone jusqu'a la zone où la vitesse 
    des vents atteind 64 nœuds en km modélisé"),
  
  p(strong("Modifications apportées aux données :")),
  p("Avant 1979 les détections des cyclones ne se faisiant pas par satellite 
    (Xu et al., 2024), ce qui implique que certains d'entre eux n'ont peut être 
    jamais été enregistrés dans nos données. Nous ferons donc nos analyses à 
    partir de 1979, date a partir de laquelle les détectons des cyclones sont 
    devenues satellitaires et donc exhaustives, pour éviter un biais 
    d'échantillonnage."),
  p("Les colonnes R34, R50 et R64 montrent beaucoup de données manquantes et la 
    variable Rmax donne des informations similaires. Les colonnes R34, R50 et 
    R64 ne seront donc non utilisées ici."),
  p("Nous avons choisi de nous focaliser ici sur l'océan Pacifique."),
  
  p(strong("Appercu du tableau de données :")),
)
)

texte_page_2 <- list(para1 = tagList(
  p("Nous avons à disposition dans le jeu de données les coordonnées des 
  cyclones toutes les 3h. Ainsi, nous pouvons représenter les 
  cyclones sur une carte interactive en choisissant de montrer ceux
  d'une année ou d'une période. Les cyclones sont coloriés selon la variable 
  choisie, permettant de visualiser l'évolution des caractéristiques d'un même 
  cyclone au cours du temps avec notamment: la vitesse maximale (Vmax), la 
  pression au centre du cyclone (Pression), le rayon entre le centre du cyclone 
  et la bande ou les vents atteignent leur vitesse maximale (Rmax) ou le sens 
  de déplacement du cyclone avec la variable Heures de vie. Il est également 
  possible de cliquer sur un point pour obtenir toutes les informations le 
  concernant."),
)
)

texte_page_3A <- list(para1 = tagList(
  p("Sur cette page nous proposons de représenter l'évolution de différentes 
    variables décrivant les caractéristiques des cyclones au cours du temps avec
    au choix:"),
  p("La vitesse maximale des vent (vmax), la pression au centre du 
    cyclone (Pression), le rayon entre le centre du cyclone et la bande ou les 
    vents atteignent leur vitesse maximale (Rmax) et enfin le nombre de cyclone 
    (Nombre)."),
  p("Ici, il est possible de voir la variation au cours de l'année 
    et sur les différentes années de la variable choisie."),
  p("Pour la variable 'Nombre' les quantiles (q1 et q2) n'ont pas d'impact."),
  p("Pour les autres variables, chaques cyclones est résumé par son quartile 
    q1. Chaque mois s'exprime comme le quartile q2 du quantile précedent sur la 
    variable choisi pour les cyclones qui commence dans le mois.
      "),
  p("Exemple : "),
  p("Si pour pression q1 = 0 et q2 = 0.5, alors on regarde comment évolue la
    mediane (0.5) de la pression minimale (0) de chaques cyclones."),
  p("Si pour vmax q1 = 0.5 et q2 = 1, alors on regarde la plus grande (1) 
    vitesse maximale mediane (0.5) de chaques cyclones."),
  
  
  p("Il est conseiller de regarder les plus grandes valeures de vmax, q1 = 0.9 
    et les plus petites valeures de rmax et pression, q1 = 0.1")
)
)

texte_page_3B <- list(para1 = tagList(
  p("Sur cette page nous proposons de représenter l'évolution de différentes 
    variables décrivant les caractéristiques des cyclones au cours du temps avec
    au choix: La vitesse maximale des vent (vmax), la pression au centre du 
    cyclone (Pression), le rayon entre le centre du cyclone et la bande ou les 
    vents atteignent leur vitesse maximale (Rmax) et enfin le nombre de cyclone 
    (Nombre). Cette évolution est représentée par des graphiques montrant les 
    moyennes de la variable choisie pour chaque années. Une courbe de régression 
    bleue foncée ainsi qu'une bande bleue clair montrant l'incertitude de cette 
    régression sont également représentées."),
  
)
)


texte_page_3C <- list(para1 = tagList(
  p("Sur cette page nous montrons les corrélations entre la vitesse maximale des 
  vent (vmax), la pression au centre du cyclone (Pression) et le rayon entre le 
  centre du cyclone et la bande ou les vents atteignent leur vitesse maximale 
  (Rmax). Nous pouvons voir que vmax, rmax et la pression sont anti-corrélés. 
  Autrement dit, plus la pression diminue, plus vmax et rmax augmentent.")
  
)
)

texte_page_conclusion <- list(para1 = tagList(
  p("Les données à notre disposition nous permettent de voir des variations au 
    cours du temps des caractéristiques des cyclones, liées au réchauffement 
    climatique : En effet, la vitesse maximale des vents (vmax) a augmentée au 
    cours du temps. À l'inverse, la pression (pression) au centre des cyclones 
    et leur rayon entre le centre et la bande des vents les plus forts (rmax) 
    ont diminués."),
  
  p("A titre d'interprétation, la baisse de la pression au centre des cyclones 
  et l'augmentation de la vitesse maximale des vents au cours du temps 
  s'explique très bien par le réchauffement climatique. En effet, l'augmentation
  de la température de surface des océans favorise des ascendances d'air plus 
  forte d'où des vents plus forts."),
  
  p("Contrairement à se qu'on aurait pu penser, une augmentation du nombre de 
  cyclones dans le context actuel de réchauffement climatique n'est pas 
  observé avec nos données. En revanche, ces cyclones sont davantage dangereux
  car capable de développer des vents plus puissants. Aussi, il semble qu'un 
  plus grand pourcentage de cyclones touchent les continents, comme montré dans
  le diargramme en bâton. "),
)
)
