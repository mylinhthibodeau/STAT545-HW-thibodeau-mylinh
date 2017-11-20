# USER INTERFACE 

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

## ui.R ##
fluidPage(
	shinyjs::useShinyjs(),
	
	tabsetPanel(

# SECTION 1		
		tabPanel(
			actionButton(inputId = "submit", label = "Click here if you don't know anything about genetics"), 
			
			"User input",
			tags$h1("Genomic Disorders Exploration"),
			tags$hr(),
			
			tags$h2("Disclaimer. This app has been made for learning purposes only."),
			img(src="brainprocess.jpg", width="30%"),
			tags$br(),
			tags$hr(),

			tags$h2("Start here !!"),
			
			textInput(inputId = "phenotype_input", tags$strong("Enter a phenotype (e.g. cleft palate):")),
	
			
			
			wellPanel(
				radioButtons(inputId = "frequency_user_input", 
					label = "Pick a expected frequency of the phenotype for the genomic disorder(s): ", choices = 
					c("Very frequent (99-80%)", 
						"Frequent (79-30%)", 
						"Occasional (29-5%)", 
						"Obligate (100%)", 
						"Excluded (0%)")
					)
				),
	
			DT::dataTableOutput(outputId = "examples_syndromes"),
		
			plotOutput(outputId = "plot1_mut_conseq"),
			
			tags$br(),
			tags$hr(),
			
			
			wellPanel(
				checkboxInput(inputId = "checkbox", 
					label = "You want to check the disorders associated with this phenotpe for a specific mutation consequence only?", FALSE),
				uiOutput("conditionalInput")
					),
			DT::dataTableOutput(outputId = "results_checkbox"),
			
			tags$br(),
			tags$hr(),
			
			tags$h1("Source of data"),
			tags$h2("All data used in this app is publicly available"),
			tags$p("DECIPHER: Database of Chromosomal Imbalance and Phenotype in Humans using Ensembl Resources. Firth, H.V. et al (2009). Am.J.Hum.Genet 84, 524-533 (DOI: dx.doi.org/10/1016/j.ajhg.2009.03.010).\n
				A full list of centres who contributed to the generation of the data is available 
				from http://decipher.sanger.ac.uk and via email from decipher@sanger.ac.uk. Funding for the project was provided by the Wellcome Trust."),
			tags$p("Gray KA, Yates B, Seal RL, Wright MW, Bruford EA. genenames.org: the HGNC resources in 2015. Nucleic Acids Res. 2015 Jan;43(Database issue):
				D1079-85. doi: 10.1093/nar/gku1071. PMID:25361968."),
			tags$p("HGNC Database, HUGO Gene Nomenclature Committee (HGNC), EMBL Outstation - Hinxton, European Bioinformatics Institute, 
				Wellcome Trust Genome Campus, Hinxton, Cambridgeshire, CB10 1SD, UK www.genenames.org. Complete HGNC dataset downloaded", 
					tags$a("HERE", href = "https://www.genenames.org/cgi-bin/statistics")),
			tags$p("Orphanet: an online database of rare diseases and orphan drugs. Copyright, INSERM 1997. 
				Available at http://www.orpha.net", tags$a("HERE", href = "http://www.orpha.net"), "(Accessed November 17, 2017)."),
					tags$p("Orphadata: Free access data from Orphanet. © INSERM 1997. Available on http://www.orphadata.org. Data version (XML data version en_product4_HPO.xml and en_product6.xml)."
				)
			),
	
# SECTION 2
		tabPanel(
			"Add organ selection",
			tags$h1("Add an additional organ involved"),
			tags$p("This page is for you to select an organ affected by the disorder."),
			wellPanel(	
				fluidRow(column(2, offset=1 ,
					radioButtons(inputId = "organs_user_input", label = "Select an additional target organ involved (optional):", choices = 
						c(
								"None",
								"Bone Marrow/Immune",
								"Brain/Cognition",
								"Cancer predisposition",
								"Ear",
								"Endocrine",
								"Endocrine/Metabolic",
								"Eye",
								"Eye: Lens",
								"Eye: Retina",
								"Face",
								"Genitalia",
								"GI tract",
								"Hair/Nails",
								"Heart/Cardiovasculature/Lymphatic",
								"Kidney Renal Tract",
								"Liver",
								"Lungs",
								"Multisystem",
								"Musculature",
								"Peripheral nerves",
								"Respiratory tract",
								"Skeleton",
								"Skin",
								"Spinal cord/Peripheral nerves",
								"Teeth & Dentitian")
							))
						)),
		
				# Table depending on organs will only be displayed when click
			tags$h4(
					"To make the table according to the phenotype feature entered initially\n
					and the target organ selected above \n
					(or to refresh the table if you changed the selected target organ)!"),		
			actionButton(inputId = "ready", label = "CLICK HERE"), 
					
				
			DT::dataTableOutput(outputId = "syndromes_and_organs"),
		
				tags$br(),	
				tags$hr(),
			
					tags$h1("Source of data"),
					tags$h2("All data used in this app is publicly available"),
					tags$p("DECIPHER: Database of Chromosomal Imbalance and Phenotype in Humans using Ensembl Resources. Firth, H.V. et al (2009). Am.J.Hum.Genet 84, 524-533 (DOI: dx.doi.org/10/1016/j.ajhg.2009.03.010).\n
						A full list of centres who contributed to the generation of the data is available from http://decipher.sanger.ac.uk and via email from decipher@sanger.ac.uk. Funding for the project was provided by the Wellcome Trust."),
					tags$p("Gray KA, Yates B, Seal RL, Wright MW, Bruford EA. genenames.org: the HGNC resources in 2015. Nucleic Acids Res. 2015 Jan;43(Database issue):D1079-85. doi: 10.1093/nar/gku1071. PMID:25361968."),
					tags$p("HGNC Database, HUGO Gene Nomenclature Committee (HGNC), EMBL Outstation - Hinxton, European Bioinformatics Institute, Wellcome Trust Genome Campus, Hinxton, Cambridgeshire, CB10 1SD, UK www.genenames.org. Complete HGNC dataset downloaded", 
						tags$a("HERE", href = "https://www.genenames.org/cgi-bin/statistics")),
					tags$p("Orphanet: an online database of rare diseases and orphan drugs. Copyright, INSERM 1997. Available at http://www.orpha.net", tags$a("HERE", href = "http://www.orpha.net"), "(Accessed November 17, 2017)."),
					tags$p("Orphadata: Free access data from Orphanet. © INSERM 1997. Available on http://www.orphadata.org. Data version (XML data version en_product4_HPO.xml and en_product6.xml)."
				)
		),

# SECTION 3	
		tabPanel(
			"Overview of souce data",
				tags$h1("Overview of source data"),
				
				tags$h2("Overview of allelic requirement distribution in aggregated data"),
				plotOutput(outputId = "plot_summary_allelic"),
					
				tags$h2("Distribution of phenotypes frequencies"),
				plotOutput(outputId = "plot_summary_phenotype"),
				
				tags$h2("Overview of organs affected distribution in aggregated data"),
				plotOutput(outputId = "plot_summary_organs"),
				
				tags$h2("Sample of gene-phenotype association"),
				tableOutput(outputId = "summary_phenotype_table"),
				
				tags$h2("Examples of phenotype choices"),
				tableOutput(outputId = "phenotype_choices_table"),
						
				tags$br(),
				tags$hr(),		
	
# SOURCE OF DATA
					tags$h1("Source of data"),
					tags$h2("All data used in this app is publicly available"),
					tags$p("DECIPHER: Database of Chromosomal Imbalance and Phenotype in Humans using Ensembl Resources. Firth, H.V. et al (2009). Am.J.Hum.Genet 84, 524-533 (DOI: dx.doi.org/10/1016/j.ajhg.2009.03.010).\n
						A full list of centres who contributed to the generation of the data is available from http://decipher.sanger.ac.uk and via email from decipher@sanger.ac.uk. Funding for the project was provided by the Wellcome Trust."),
					tags$p("Gray KA, Yates B, Seal RL, Wright MW, Bruford EA. genenames.org: the HGNC resources in 2015. Nucleic Acids Res. 2015 Jan;43(Database issue):D1079-85. doi: 10.1093/nar/gku1071. PMID:25361968."),
					tags$p("HGNC Database, HUGO Gene Nomenclature Committee (HGNC), EMBL Outstation - Hinxton, European Bioinformatics Institute, Wellcome Trust Genome Campus, Hinxton, Cambridgeshire, CB10 1SD, UK www.genenames.org. Complete HGNC dataset downloaded", 
					tags$a("HERE", href = "https://www.genenames.org/cgi-bin/statistics")),
					tags$p("Orphanet: an online database of rare diseases and orphan drugs. Copyright, INSERM 1997. Available at http://www.orpha.net", tags$a("HERE", href = "http://www.orpha.net"), "(Accessed November 17, 2017)."),
					tags$p("Orphadata: Free access data from Orphanet. © INSERM 1997. Available on http://www.orphadata.org. Data version (XML data version en_product4_HPO.xml and en_product6.xml)."
			)
	)
))