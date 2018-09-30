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
      helpText("Worried about all that time you spend bindge youtube watching??
      Worry no more.
      With My Time! you can keep track of
      your working behaviour in an easy non invasive way. The graphs to the right
      show the frequency of topics appearing on your desktop for any amount of time.
      Try changing the time and look how your browsing behaviour changes through
      the day to make your day more productive!"), br(),
      sliderInput("minutes", "The past minutes of my life:",
                    min = 1,  max = 525600, value = 1), br(),
      actionButton("cat", "Show me my more!"),
      # actionButton("wc", "Show me my cloud"),
      br(),
      imageOutput(outputId = "freq")

    ),
    # Main panel for displaying outputs ----
    mainPanel(
      # ig only worksif you have an app.R file with both ui and server there
      # img(source = "rstudio.png", width = 400, height = 140)
      # img(source = "bananya_brushing.jpg", width = 400, height = 140)
    # imageOutput("rstudio", width = 40, height = 14),
    # imageOutput("cat", width = 40, height = 14)
      uiOutput(outputId = "wordcloud", align = "center")

    )
  )
)
