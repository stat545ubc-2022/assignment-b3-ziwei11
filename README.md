# Steam Games Data Plots App

## App Link
https://zhaovicky1117.shinyapps.io/assignment-b3-ziwei11/


## Assignment Option

Option B - my own Shiny app


## Description

This app uses `steam_games` dataset to show a plot which is a histogram of the original_price in the chosen date range, and a DT table of the data corresponding to the chosen date range.


## Features

1. Add an image to the UI by `img()` function
    - An image can make the app more visually interesting and attract users.

2. Add a date filter to the UI by `dateRangeInput()` function
    - Filter the date range we would like to use in the plots.

3. Add a text output to the UI by `textOutput()` and `renderText()` function
    - Show the number of results found whenever the date filters change.

4. Add a tabset to the main panel UI by `tabsetPanel()` function
    - Create an interface with multiple tabs,
    - and place plots and tables in separate tabs.

5. Filter and select the data which is useful

6. Create an interactive data table by using the DT package, `DT::dataTableOutput()` function, and `DT::renderDataTable()` function
    - Turn a static table into an interactive table.


## Dataset Acknowledgement

The `steam_games` dataset is from the `datateachr` package by Hayley Boyce and Jordan Bourak which currently composed of 7 semi-tidy datasets for educational purposes. 

Install the [`datateachr`](https://github.com/UBC-MDS/datateachr) package by typing the following into your **R terminal**:

<!-- -->
    install.packages("devtools")
    devtools::install_github("UBC-MDS/datateachr")

