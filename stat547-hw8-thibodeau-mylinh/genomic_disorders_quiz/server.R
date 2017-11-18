#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/


# Increase size for upload (https://stackoverflow.com/questions/18037737/how-to-change-maximum-upload-size-exceeded-restriction-in-shiny-and-save-user)
options(shiny.maxRequestSize=30*1024^2) 

# change working directory
setwd("~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw8-thibodeau-mylinh/genomic_disorders_quiz/")

# load library
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


## server.R ##
function(input, output) {
	genomic_disorders <- read_tsv("data/DDG2P_hgnc_orphadata.tsv")
	organs_choices <- read_tsv("data/organs_choices.tsv")
	
	# str_to_lower to genomic_disorders data phenotypic features to ensure match with user input
	genomic_disorders <- genomic_disorders %>%
		mutate(phenotype_name = str_to_lower(phenotype_name))
	
	# str_to_lower to phenotype_user_entered to ensure match with genomic_disorders
	output$phenotype_user_entered <- renderText({
		str_to_lower(input$phenotype_input)})
	
	filtered_genomic_disorders <- reactive({
		genomic_disorders %>%
			filter(phenotype_name == input$phenotype_input[1]) %>%
			filter(frequency == input$frequency_user_choice[1])
	})
	
	output$frequency_user_choice <- renderPrint({
		input$frequency_choices[1]
	})
	
	output$examples_syndromes <- renderTable({
		filtered_genomic_disorders()
	})

	
	output$plot1 <- renderPlot({
		genomic_disorders %>%
			ungroup() %>%
			mutate(allelic.requirement = allelic.requirement %>% fct_infreq() %>% fct_rev()) %>%
			ggplot(aes(x=allelic.requirement)) +
			geom_bar(aes(fill = allelic.requirement)) +
			ggtitle("Allelic requirement distribution (all genomic disorders)") +
			theme_bw() + theme(
				plot.title= element_text(color = "grey44", size=18, face="bold"),
				text = element_text(size =12), axis.text.x = element_text(angle=45, hjust=1))
	})
	
	output$plot2 <- renderPlot({
		filtered_genomic_disorders() %>%
			ungroup() %>%
			ggplot(aes(x=factor(1), fill=mutation.consequence)) +
			geom_bar(width =1) + coord_polar("y")
	})
}
