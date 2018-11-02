ui <- fluidPage(
  br(),
  # App title ----
  tags$head(
    tags$div(class="title", titlePanel("My Time!"),
    align = "center",
    style =
      ".title {margin: auto; width: 100%; padding = 7px}")
  ),
  # tags$div(class="title", titlePanel("Personal Knowledge Analyses")),

  br(),br(),
  sidebarLayout(
    # Sidebar panel for inputs ----
    sidebarPanel(
      helpText("Worried about all that time you spend bindge watching youtube??
      Worry no more.
      With My Time! you can keep track of
      your working behaviour in an easy, non invasive way. The graphs to the right
      show the frequency of topics appearing on your desktop for any amount of time.
      Try changing the time and look how your browsing behaviour changes through
      the day to make your day more productive!"), br(),
      sliderInput("minutes", "The past minutes of my time:",
                    min = -30,  max = -1, value = -30, animate = TRUE), br(),
      radioButtons("graphtype", "Show me more!",
             c("Topic cloud" = "tc",
               "Topic frequency" = "tf")),
      br()
    ),
    # Main panel for displaying outputs ----
    mainPanel(
      # the two following only works if you have an app.R file with both ui and server there
      # img(source = "rstudio.png", width = 400, height = 140)
      # img(source = "bananya_brushing.jpg", width = 400, height = 140)
    # the following two work now 
    # imageOutput("rstudio", width = 40, height = 14),
    # imageOutput("cat", width = 40, height = 14)
      uiOutput(outputId = "maingraph", align = "center", height = "100%")
    )
  )
)
