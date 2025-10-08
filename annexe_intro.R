texte_into <- list(para1 = tagList(
  h2("Comment ont évolué les caractéristiques des cyclones dans le Pacifique entre 1979 et 2022 ?"),
  
  p(strong("Informations sur les données :")),
  p("les données sont issues de Xu et al., 2024 
    (https://doi.org/10.5194/essd-2024-329). Il s'agit de données décrivant la 
    taille et l'intensité des cyclones tropicaux (TC) à l'échelle mondiale entre
    1959 à 2022, avec une résolution temporelle de 3 heures. Les données 
    proviennent d'une fusion des données IBTrACS (International Best Track 
    Archive for Climate Stewardship) et ERA5 (European Centre for MediumRange 
    Weather Forecasts Reanalysis 5), enrichies de 2 variables :"),
  p("-Le rayon du vent maximal (RMW), qui est la distance entre le centre du 
    cyclone et la bande ou se trouve les vents les plus forts."),
  p("-La pression minimale au centre du TC."),
  p("-Les diamètres de TC (R)."),
  p("ATTETION IL Y EN A TROIS PAS DEUX"),
  
  p(strong("Explication des colonnes :")),
  p("- numéro : indice du TC (issu des données IBTrACS)"),
  p("- nom : nom du TC (issu des données IBTrACS)"),
  p("- année : année du TC (issu des données IBTrACS)"),
  p("- mois : mois du TC (issu des données IBTrACS)"),
  p("- jour : jour du TC (issu des données IBTrACS)"),
  p("- heure : heure du TC (issu des données IBTrACS)"),
  p("- nature : nature du TC (issu des données IBTrACS) avec :"),
  p("    DS : Perturbation"),
  p("    ET : Extratropical"),
  p("    MX : Mélange ou rapports contradictoires de nature provenant de 
    différentes agences"),
  p("    NR : Non rapporté"),
  p("    ST : Subtropical"),
  p("    TS : Tropical"),
  p("- lat : latitude (issu des données IBTrACS)"),
  p("- lon : longitude (issu des données IBTrACS)"),
  p("- terre : touche terre indique si un TC a touché terre"),
  p("- vmax : la vitesse maximale du vent (m.s-1), dérivée par des modèles de 
    forêts aléatoires avec les profils de vent azimutaux moyens à 10 m issus des
    données ERA5 comme entrée, et la vitesse maximale du vent des données 
    IBTrACS comme données d'apprentissage"),
  p("- pression : la pression centrale minimale, dérivée par un modèle empirique
    de la relation vent-pression"),
  p("rmax : RMW est dérivé par des modèles de forêts aléatoires avec les profils
    de vent azimutaux moyens à 10 m dérivés de l'ERA5 comme entrée, et le rayon 
    du vent maximal de l'IBTrACS comme cible d'apprentissage"),
  p("-R34 : distances depuis le centre du cyclone jusqu'a la zone où la vitesse 
    du vent atteind 34 nœuds."),
  p("-R50 : distances depuis le centre du cyclone jusqu'a la zone où la vitesse 
    du vent atteind 50 nœuds."),
  p("-R64 : distances depuis le centre du cyclone jusqu'a la zone où la vitesse 
    du vent atteind 64 nœuds."),
  
  p(strong("Problématisation :")),
  p("Les cyclones tropicaux sont des phénomènes météorologiques pouvant être 
    dévastateurs pour les installations humaines. Le dérèglement climatique en 
    cours perturbe les mécanismes à l'origine de ces cyclones et donc leurs 
    caractéristiques au cours du temps. Ainsi, la compréhenssion de l'évolution 
    des caractéristiques des cyclones est nécessaire pour protéger les 
    populations des risques issus de ces cyclones en contexte de changements 
    climatiques. Nous proposons donc ici l'évolution au cours du temps des 
    caractéristiques des cyclones. Ceci sera montré a travers une application 
    destiné à de la médiation scientifique")
),
para2 = tagList(
  p("Avant 1979 les détections de cyclone ne se faisiant pas par satellite 
    (Xu et al., 2024), ce qui implique que certains d'entre eux n'ont peut être 
    jamais été enregistré dans les données. Nous ferons donc nos analyses 
    (notamment de fréquence) à partir de 1979 pour éviter un biais 
    d'échantillonnage. R34, R50 et R64 avec beacoup de NA donc non utilisées 
    ici."), 
  p("exploration données:"),
  p("Carte sur une année avec une réglette pour balayer de 1959 à 2020. Sur 
    cette carte on représente la trace des cyclone. En cliquant sur une trace on
    peut avoir accès a une fiche descriptive du cyclone. "),

  p("analyse"),

  p("Application:"),
  p("Plusieurs pages:"),

  p("-Page 1: Introduction"),
  p("°1. D'ou viennent nos données (parler de l'article)"),

  p("°2. Explication de la problématique:"),
  p("Comment on changées les caractéristiques des cyclones tropicaux entre 1979 
    et 2022"),

  p("°3. Description du phénomène cyclone avec regression pression = 
    f(vent max)"),
  p("°4. Montrer un graph qui montre la saisonnalité"),

  p("-Page 2: Exploration des données"),
  p("°On se focalise sur un bassin (a bien justifier)"),
  p("Choix d'une période de temps qui permet d'afficher les cyclones sur une 
    carte. Quand on clic sur le cyclone, on obtient une fiche avec le nom, 
    l'année et ces caractéristiques"),
                               
  p("°Onglet ou on choisi date, vmax>100, ... qui permet de sélectionner des 
    cyclones a afficher sur la carte. "),
                               
  p("-Page 3: Jouer avec les statistiques"),
  p("Plots avec regressions variable = f(temps) a tester si les points sont des 
    moyennes ou des quantiles"),
  p("Plots d'une variable sur les mois pour différentes années"),
  p("Avec un texte bref pour expliquer le graph généré par l'utilisateur"),
                               
  p("-Page 4: Conclusion (= réponse à la problématique)"),
  p("°Sélection des graphs les plus pertinents pour répondre à la problématique 
    avec des analyses statistiques (choisir par exemple entre regression pour 
    des moyennes ou des médiannes)"),
  p("°Une carte avec la première décade et une carte avec la dernière décade")
                               
)
)
