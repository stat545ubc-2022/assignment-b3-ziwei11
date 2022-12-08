library(shiny)
library(ggplot2)
library(DT)
library(datateachr)
library(tidyverse)
library(dplyr)
data(steam_games)

ui <- fluidPage(
  titlePanel("Steam Games Data Plots App"),
  # Feature 9: Add CSS to make the app look nicer.
  # In the CSS file, the background color and ui element color are changed to
  # match steam-like color palette.
  includeCSS("www/style.css"),
  sidebarLayout(
    sidebarPanel(
      # Feature 1: Add an image to the UI.
      # An image can make the app more visually interesting and attract users.
      img(src = "steam_games.png", width = "100%"),
      br(),
      br(),
      # Feature 2: Add a date filter to the UI.
      # Filter the date range we would like to use in the plots.
      dateRangeInput("dateInput",
        label = "Choose Release Date Range: ",
        start = as.Date("2008-09-02", "%Y-%m-%d"),
        end = as.Date("2019-03-07", "%Y-%m-%d")
      ),
      # Feature 3: Add a text output to the UI.
      # Show the number of results found whenever the date filters change.
      textOutput("text"),
      # Feature 8: Allow the user to select different variables to display in
      # the plot using `selectInput()` function
      selectInput("price", "Price", c("original_price", "discount_price")),
    ),
    mainPanel(
      # Feature 4: Add a tabset to the main panel UI.
      # Create an interface with multiple tabs,
      # and place plots and tables in separate tabs.
      tabsetPanel(
        type = "tabs",
        tabPanel(
          "Data Plot",
          plotOutput("countPlot")
        ),
        tabPanel(
          "Data Table",
          br(),
          # Feature 7: Allow the user to download the table as a .csv file
          # using `downloadButton()` function.
          downloadButton("download_table", "Download Data Table"),
          br(),
          br(),
          DT::dataTableOutput("table"),
          br(),
          br()
        )
      )
    )
  )
)

server <- function(input, output) {
  # Feature 5: Filter and select the data which is useful.
  filtered <- reactive({
    steam_games %>%
      mutate(date_release = format(as.Date(release_date, "%b %d, %Y"), "%Y-%m-%d")) %>%
      drop_na(date_release) %>%
      filter(original_price < 100 & discount_price < 100) %>%
      filter(
        date_release <= input$dateInput[2],
        date_release >= input$dateInput[1]
      ) %>%
      select(id, name, developer, publisher, recent_reviews, all_reviews, date_release, original_price, discount_price)
  })

  output$text <- renderText({
    paste("We found", nrow(filtered()), "options for you.")
  })

  output$countPlot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    # Feature 8: Allow the user to select different variables to display in
    # the plot using `selectInput()` function
    ggplot(filtered(), aes(x = get(input$price))) +
      geom_histogram(colour = "grey", fill = "lightgreen", bins = 60) +
      xlab(input$price) + theme(plot.background = element_rect(fill = "#c7d5e0"))
  })

  # Feature 6: Create an interactive data table by using the DT package.
  # Turn a static table into an interactive table.
  output$table <- DT::renderDataTable(
    filtered()
  )

  # Feature 7: Allow the user to download the table as a .csv file using
  # `downloadButton()` function.
  output$download_table <- downloadHandler(
    filename = function() {
      paste("filtered-steam-games", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(as.data.frame(filtered()), file)
    }
  )
}

shinyApp(ui = ui, server = server)
