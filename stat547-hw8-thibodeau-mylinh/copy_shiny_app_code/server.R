# SERVER

# Increase size for upload (https://stackoverflow.com/questions/18037737/how-to-change-maximum-upload-size-exceeded-restriction-in-shiny-and-save-user)
options(shiny.maxRequestSize=30*1024^2) 

# LIBRARY
suppressMessages(suppressWarnings(library(shiny)))
suppressMessages(suppressWarnings(library(tidyverse)))
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
	genomic_disorders_organs_listed <- read.table("data/DDG2P_hgnc_orphadata_organs_listed.tsv", sep = "\t", header = TRUE)
	#genomic_disorders <- read.table("data/DDG2P_hgnc_orphadata.tsv", sep = "\t", header = TRUE)
	#organs_choices <- read.table("data/organs_choices.tsv", sep = "\t", header = TRUE)
	#organs_genes <- read.table("data/genes_organs_gather.tsv", sep = "\t", header = TRUE)
	phenotypes_choices <- read.table("data/orphadata_phenotype_choices.tsv", sep = "\t", header = TRUE)
	
	# str_to_lower to genomic_disorders data phenotypic features to ensure match with user input
	# genomic_disorders <- genomic_disorders %>%
		# mutate(phenotype_name = str_to_lower(phenotype_name))
		
	genomic_disorders_organs_listed <- genomic_disorders_organs_listed %>%
		mutate(phenotype_name = str_to_lower(phenotype_name))
	
## REACTIVE ENVIRONMENT START POINT (endpoint filtering here, breakdown of sections below)
	
	# str_to_lower to phenotype_user_entered to ensure match with genomic_disorders
	
	filtered_genomic_disorders <- reactive({
		genomic_disorders_organs_listed %>%
			filter(phenotype_name == str_to_lower(input$phenotype_input[1])) %>%
			filter(frequency == input$frequency_user_input[1]) %>%
			filter(!duplicated(disorder_name))
	})
	
	## eventReactive
	filtered_genomic_disorders_organs_selected <- eventReactive(input$ready,
		{
			genomic_disorders_organs_listed %>%
			filter(phenotype_name == str_to_lower(input$phenotype_input[1])) %>% 
			filter(frequency == input$frequency_user_input[1]) %>% 	
			filter(organs_affected == input$organs_user_input[1])
	})
	
	
## OBSERVE - trigers the code to run on the server 
	observeEvent(input$ready, { print(as.numeric(input$ready))})
	# Read on the observe() - might be useful for quiz format

	
		
## OUTPUT RENDER BLOCK
	output$frequency_user_input <- renderPrint({
		input$frequency_user_input[1]
	})
	
	output$organs_user_input <- renderPrint({
		input$organs_user_input
	})
	
	
	# Reactive table render (based on user phenotype entered, frequency of phenotypic feature and organs affected)
	output$examples_syndromes <- renderTable({
		filtered_genomic_disorders()
	})

# This will be REACTIVE to the click		
	output$syndromes_and_organs <- renderTable({
		filtered_genomic_disorders_organs_selected()
	})
	
	
	# Reactive plot render - mutation.consequence
	output$plot1_mut_conseq <- renderPlot({
		filtered_genomic_disorders() %>%
			ungroup() %>%
			mutate(mutation.consequence = mutation.consequence %>% fct_infreq() %>% fct_rev()) %>%
			ggplot(aes(x = mutation.consequence)) +
			geom_bar(aes(fill = mutation.consequence)) +
			ggtitle("Distribution of mutation consequence types for phenotype feature entered") +
			theme_bw() + theme(
				plot.title= element_text(color = "grey44", size=18, face="bold"),
				text = element_text(size =12), axis.text.x = element_text(angle=45, hjust=1))
	})
	
## SUMMARY of genomic disorders data - Some plots (not reactive)
	output$plot_summary_allelic <- renderPlot({
		genomic_disorders_organs_listed %>%
			ungroup() %>%
			mutate(allelic.requirement = allelic.requirement %>% fct_infreq() %>% fct_rev()) %>%
			ggplot(aes(x=allelic.requirement)) +
			geom_bar(aes(fill = allelic.requirement)) +
			ggtitle("Allelic requirement distribution (all genomic disorders)") +
			theme_bw() + theme(
				plot.title= element_text(color = "grey44", size=18, face="bold"),
				text = element_text(size =12), axis.text.x = element_text(angle=45, hjust=1))
	})
	
	output$plot_summary_phenotype <- renderPlot({
		genomic_disorders_organs_listed %>%
		ungroup() %>%
			#select(gene.symbol, phenotype_name) %>%
			filter(phenotype_name != "") %>%
			filter(!is.na(phenotype_name)) %>%
			mutate(phenotype_name = phenotype_name %>% fct_infreq() %>% fct_rev()) %>%
			unique() %>%
			group_by(disorder_name) %>%
			#head(50) %>% 
			ggplot(aes(x=phenotype_name)) +
			stat_count(show.legend= FALSE) +
			ggtitle("Phenotypic features - Distribution (all genomic disorders)") +
			theme_bw() + theme(
				plot.title= element_text(color = "grey44", size=18, face="bold"),
				axis.title.x=element_blank(),
				axis.text.x = element_blank())
	})
	
	output$plot_summary_organs <- renderPlot({
		genomic_disorders_organs_listed %>%
			ungroup() %>%
			filter(organs_affected != "") %>%
			mutate(organs_affected = organs_affected %>% fct_infreq() %>% fct_rev()) %>%
			ggplot(aes(x=organs_affected)) +
			geom_bar(aes(fill = organs_affected)) +
			ggtitle("Organs affected - Distribution (all genomic disorders)") +
			theme_bw() + theme(
				plot.title= element_text(color = "grey44", size=18, face="bold"),
				text = element_text(size =12), axis.text.x = element_text(angle=45, hjust=1))
	})
	
	output$summary_phenotype_table <- renderTable({
		genomic_disorders_organs_listed %>%
			select(gene.symbol, phenotype_name) %>%
			ungroup() %>%
			filter(phenotype_name != "") %>%
			unique() %>%
			group_by(phenotype_name) %>%
			head(10)
	})
	
	output$phenotype_choices_table <- renderTable({
		phenotypes_choices %>%
			head(10)
		
	})
	
}
