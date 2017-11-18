#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

suppressMessages(suppressWarnings(library(shiny)))
suppressMessages(suppressWarnings(library(ggplot2)))
suppressMessages(suppressWarnings(library(dplyr)))
suppressMessages(suppressWarnings(library(plotly)))
suppressMessages(suppressWarnings(library(shinydashboard)))
suppressMessages(suppressWarnings(library(shinythemes)))
suppressMessages(suppressWarnings(library(DT)))
suppressMessages(suppressWarnings(library(leaflet)))
suppressMessages(suppressWarnings(library(shinyjs)))
suppressMessages(suppressWarnings(library(V8)))
suppressMessages(suppressWarnings(library(reshape)))
suppressMessages(suppressWarnings(library(stringr)))
suppressMessages(suppressWarnings(library(forcats)))
suppressMessages(suppressWarnings(library(ggmap)))
suppressMessages(suppressWarnings(library(maptools)))
suppressMessages(suppressWarnings(library(maps)))

## ui.R ##
fluidPage(
	titlePanel("Genomic Disorders"),
	textInput("phenotype_input", "Enter a phenotype (e.g. cleft palate):"),
	textOutput("phenotype_user_entered"),
	radioButtons("frequency_user_choice", label = "Pick a frequency for the feature: ", choices = c("Very frequent (99-80%)", "Frequent (79-30%)", "Occasional (29-5%)", "Obligate (100%)", "Excluded (0%)")),
	mainPanel(tableOutput("examples_syndromes"),
	plotOutput("plot1"),
	plotOutput("plot2"),
	verbatimTextOutput("frequency_user_choice")
	)
)
