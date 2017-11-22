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
suppressMessages(suppressWarnings(library(shinysky)))
suppressMessages(suppressWarnings(library(colourpicker)))
suppressMessages(suppressWarnings(library(V8)))
suppressMessages(suppressWarnings(library(reshape)))
suppressMessages(suppressWarnings(library(stringr)))
suppressMessages(suppressWarnings(library(forcats)))
suppressMessages(suppressWarnings(library(ggmap)))
suppressMessages(suppressWarnings(library(maptools)))
suppressMessages(suppressWarnings(library(maps)))

# GET THE GENOMIC DATA	

genomic_disorders_organs_listed <- read.table("data/DDG2P_hgnc_orphadata_organs_listed.tsv", sep = "\t", header = TRUE)
#genomic_disorders <- read.table("data/DDG2P_hgnc_orphadata.tsv", sep = "\t", header = TRUE)
#organs_choices <- read.table("data/organs_choices.tsv", sep = "\t", header = TRUE)
#organs_genes <- read.table("data/genes_organs_gather.tsv", sep = "\t", header = TRUE)

phenotypes_choices <- read.table("data/orphadata_phenotype_choices.tsv", sep = "\t", header = TRUE)



## server.R ##
function(input, output) {

# FORMAT TO LOWER CASE		
	# str_to_lower to genomic_disorders data phenotypic features to ensure match with user input
	genomic_disorders_organs_listed <- genomic_disorders_organs_listed %>%
		mutate(phenotype_name = str_to_lower(phenotype_name))
	
	
###############
	
# TAB1 - FREQUENCY OF PHENOTYPE - USER INPUT	
	output$frequency_user_input <- renderPrint({
		input$frequency_user_input[1]
	})
		
# TAB 1 - TABLE 1 - PHENOTYPE
	# REACTIVE FILTERED TABLE
	filtered_genomic_disorders <- reactive({
			if (is.null(input$phenotype_input)) {
				return(NULL)
			}
		genomic_disorders_organs_listed %>%
		# str_to_lower to phenotype_user_entered to ensure match with genomic_disorders
			filter(phenotype_name == str_to_lower(input$phenotype_input[1])) %>%
			filter(frequency == input$frequency_user_input[1]) %>%
			filter(!duplicated(disorder_name))
	})
	

# TAB1 - TABLE 1 - RENDER
# PHENOTYPE 
	# REACTIVE TABLE RENDER (based on user phenotype entered, frequency of phenotypic feature and organs affected)
	output$examples_syndromes <- DT::renderDataTable({
		filtered_genomic_disorders()
	})	

# TAB 1 - TABLE - DOWNLOAD
	
	output$downloadData1 <- downloadHandler(
		filename = function() {
			paste("data-", Sys.Date(), ".csv", sep="")
		},
		content = function(file) {
			write.csv(filtered_genomic_disorders(), file)
		}
	)
	
# TAB1 - PLOT 1 - OUTPUT
# MUTATION CONSEQUENCES 
	# REACTIVE PLOT - mutation.consequence
	output$plot1_mut_conseq <- renderPlot({
		filtered_genomic_disorders() %>%
			ungroup() %>%
			mutate(mutation.consequence = mutation.consequence %>% fct_infreq() %>% fct_rev()) %>%
			ggplot(aes(x = mutation.consequence)) +
			geom_bar(aes(fill = mutation.consequence)) +
			ggtitle("Distribution of mutation consequence types for phenotype feature entered") +
			theme_bw() + theme(
				plot.title= element_text(color = "grey44", size=20, face="bold"),
				text = element_text(size =16), axis.text.x = element_text(angle=45, hjust=1))
	})	
		
# TAB 2 - TABLE 1 - CONDITIONAL + RENDERUI + OUTPUT		
# MUTATION CONSEQUENCES
	# CHECKBOX + DROPDOWN 
	# Part 1 - conditionalInput and selectInput 
	output$conditionalInput <- renderUI({
		if(input$checkbox) {
			selectInput("mut_conseq_user_input_check", "Mutation Consequence Type", 
				choices=
					c("5_prime or 3_prime UTR mutation",
						"activating",
						"all missense/in frame",
						"cis-regulatory or promotor mutation",
						"dominant negative",
						"increased gene dosage",
						"loss of function",
						"part of contiguous gene duplication",
						"uncertain"),
				selected = "loss of function"
			)
		}
	})
	
	# Part 2 - reactive table
	filtered_genomic_disorders_mut_type <- reactive({
		if (is.null(input$mut_conseq_user_input_check)) {
			return(NULL)
		}
		genomic_disorders_organs_listed %>%
			filter(phenotype_name == str_to_lower(input$phenotype_input[1])) %>%
			filter(frequency == input$frequency_user_input[1]) %>%
			filter(mutation.consequence == input$mut_conseq_user_input_check) %>%
			ungroup() %>%
			filter(!duplicated(disorder_name))
	})
	
	# Part 3 - render output table
	output$results_checkbox <- DT::renderDataTable({
		filtered_genomic_disorders_mut_type()
	})
	
# SYNDROMES - ORGANS 
# TAB 3 - TABLE 1
	# ORGAN USER INPUT
	output$organs_user_input <- renderPrint({
		input$organs_user_input
	})

	# REACTIVE FILTERED TABLE - ACTION BUTTON 
	# eventReactive
	filtered_genomic_disorders_organs_selected <- eventReactive(input$ready,
		{
			if (is.null(input$phenotype_input) || is.null(input$organs_user_input)) {
				return(NULL)
			}
			genomic_disorders_organs_listed %>%
				filter(phenotype_name == str_to_lower(input$phenotype_input[1])) %>% 
				filter(frequency == input$frequency_user_input[1]) %>% 	
				filter(organs_affected == input$organs_user_input[1]) %>%
				filter(!duplicated(disorder_name))
		})
	
	# REACTIVE RENDER TABLE 
	output$syndromes_and_organs <- DT::renderDataTable({
		filtered_genomic_disorders_organs_selected()
	})
	
# TAB 2 - TABLE - DOWNLOAD
	
	output$downloadData2 <- downloadHandler(
		filename = function() {
			paste("data-", Sys.Date(), ".csv", sep="")
		},
		content = function(file) {
			write.csv(filtered_genomic_disorders(), file)
		}
	)
	
# TAB 4 - OVERVIEW OF DATA	
## ALLELIC PLOT
	output$plot_summary_allelic <- renderPlot({
		genomic_disorders_organs_listed %>%
			ungroup() %>%
			mutate(allelic.requirement = allelic.requirement %>% fct_infreq() %>% fct_rev()) %>%
			ggplot(aes(x=allelic.requirement)) +
			geom_bar(aes(fill = allelic.requirement)) +
			ggtitle("Allelic requirement distribution (all genomic disorders)") +
			theme_bw() + theme(
				plot.title= element_text(color = "grey44", size=20, face="bold"),
				text = element_text(size =14), axis.text.x = element_text(angle=45, hjust=1))
	})

## PHENOTYPE PLOT
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
			stat_count(show.legend= FALSE, bg = input$col, col = input$col) +
			ggtitle("Phenotypic features - Distribution (all genomic disorders)") +
			theme_bw() + theme(
				plot.title= element_text(color = "grey44", size=18, face="bold"),
				axis.title.x=element_blank(),
				axis.text.x = element_blank())
	})

## ORGANS PLOT	
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

## PHENOTYPE-GENOTYPE SAMPLE TABLE
	output$summary_phenotype_table <- renderTable({
		genomic_disorders_organs_listed %>%
			select(gene.symbol, phenotype_name) %>%
			ungroup() %>%
			filter(phenotype_name != "") %>%
			unique() %>%
			group_by(phenotype_name) %>%
			head(10)
	})

## PHENOTYPE CHOICE SAMPLE TABLE	
	output$phenotype_choices_table <- renderTable({
		phenotypes_choices %>%
			head(10)
		
	})

# TAB 6 - Supplementary - All phenotypes
# Non reactive table	
	output$all_phenotypes_choices <- DT::renderDataTable({
		phenotypes_choices
	})	

}
