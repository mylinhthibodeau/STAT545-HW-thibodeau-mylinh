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
suppressMessages(suppressWarnings(library(shinysky)))
suppressMessages(suppressWarnings(library(colourpicker)))
suppressMessages(suppressWarnings(library(V8)))
suppressMessages(suppressWarnings(library(reshape)))
suppressMessages(suppressWarnings(library(stringr)))
suppressMessages(suppressWarnings(library(forcats)))
suppressMessages(suppressWarnings(library(ggmap)))
suppressMessages(suppressWarnings(library(maptools)))
suppressMessages(suppressWarnings(library(maps)))

phenotypes_choices <- read.table("data/orphadata_phenotype_choices.tsv", sep = "\t", stringsAsFactors = FALSE,header = FALSE) 

## ui.R ##
fluidPage(
	theme = "bootstrap.min.css",
	
	shinyjs::useShinyjs(),
	tabsetPanel(
		
# TAB 1 - USER PHENOTYPE + FREQUENCY
		tabPanel(
	# TAB TITLE		
			"Phenotype and frequency",
			tags$h1("Genomic Disorders Exploration"),
			tags$em("You know nothing about clinical genetics/genomics and would like to try the App? 
				No problem at all, you can check out my tutorial:", tags$strong("5th tab of the app"), 
				"or on my github README file", 
				tags$a("HERE", href ="https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw8-thibodeau-mylinh"), 
				"to get some premade scenarios to test my app !"),
			tags$hr(),
			
			wellPanel(
				fluidRow(
					column(8, align="center", offset = 2,
						
						textInput(inputId = "phenotype_input", 
							tags$em(tags$h3("Enter a phenotype (e.g. cleft palate):"))),
						tags$style(type="text/css", "#phenotype_input { height: 50px; width: 100%; text-align:center; font-size: 30px; display: block;}")
					)
					)
				),
			
			# SIDE LAYOUT
			sidebarLayout(
			# SIDE PANEL	
				sidebarPanel(
			
					radioButtons(inputId = "frequency_user_input",
						label = "Pick a expected frequency of the phenotype for the genomic disorder(s): ", 
						choices = 
						c("Very frequent (99-80%)", 
						"Frequent (79-30%)", 
						"Occasional (29-5%)", 
						"Obligate (100%)", 
						"Excluded (0%)")
				
						)
					),
			
			# MAIN PANEL		
				mainPanel(
					tags$br(),
					tags$hr(),
					tags$br(),
					plotOutput(outputId = "plot1_mut_conseq"),
					tags$br(),
					
					tags$h4(downloadButton("downloadData1", "Download"), align = "right"),
		
					DT::dataTableOutput(outputId = "examples_syndromes"),

					tags$br(),
					tags$hr(),
			
# SOURCE OF DATA - REFERENCES
			
			tags$h2("Sources/references of genomic data"),
			tags$h3("All data used in this app is publicly available"),
			tags$p("DECIPHER: Database of Chromosomal Imbalance and Phenotype in Humans using Ensembl Resources. Firth, H.V. et al (2009). Am.J.Hum.Genet 84, 524-533 (DOI: dx.doi.org/10/1016/j.ajhg.2009.03.010).\n
				A full list of centres who contributed to the generation of the data is available from http://decipher.sanger.ac.uk and via email from decipher@sanger.ac.uk. Funding for the project was provided by the Wellcome Trust."),
			tags$p("Gray KA, Yates B, Seal RL, Wright MW, Bruford EA. genenames.org: the HGNC resources in 2015. Nucleic Acids Res. 2015 Jan;43(Database issue):D1079-85. doi: 10.1093/nar/gku1071. PMID:25361968."),
			tags$p("HGNC Database, HUGO Gene Nomenclature Committee (HGNC), EMBL Outstation - Hinxton, European Bioinformatics Institute, Wellcome Trust Genome Campus, Hinxton, Cambridgeshire, CB10 1SD, UK www.genenames.org. Complete HGNC dataset downloaded", 
				tags$a("HERE", href = "https://www.genenames.org/cgi-bin/statistics")),
			tags$p("Orphanet: an online database of rare diseases and orphan drugs. Copyright, INSERM 1997. Available at http://www.orpha.net", tags$a("HERE", href = "http://www.orpha.net"), "(Accessed November 17, 2017)."),
			tags$p("Orphadata: Free access data from Orphanet. © INSERM 1997. Available on http://www.orphadata.org. Data version (XML data version en_product4_HPO.xml and en_product6.xml)."
			),
			
			tags$hr(),
			img(src="brainprocess.jpg", width="30%"),
			tags$h4("Disclaimer. This app has been made for learning purposes only.")
					)
				),
			wellPanel(tags$em("Author: My Linh Thibodeau"),
				tags$br(),
				tags$em(tags$a( "Open source code available on my Github" ,href= "https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw8-thibodeau-mylinh")),
				tags$br(),
				tags$em("Last updated November 21, 2017"))
			),
				
		
# TAB 2
		tabPanel(
		# TAB TITLE	
			"Check out this checkbox",
			tags$h1("Genomic Disorders Exploration!"),
			wellPanel(
				checkboxInput(inputId = "checkbox", 
					label = "Want a specific mutation consequence ?", FALSE),
				uiOutput("conditionalInput")
					),
			
			DT::dataTableOutput(outputId = "results_checkbox"),
			
			tags$br(),
			tags$hr(),
			
			tags$h2("Sources/references of genomic data"),
			tags$h3("All data used in this app is publicly available"),
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
			tags$p("Orphadata: Free access data from Orphanet. © INSERM 1997. Available on http://www.orphadata.org. Data version (XML data version en_product4_HPO.xml and en_product6.xml)."),
			wellPanel(tags$em("Author: My Linh Thibodeau"),
				tags$br(),
				tags$em(tags$a( "Open source code available on my Github" ,href= "https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw8-thibodeau-mylinh")),
				tags$br(),
				tags$em("Last updated November 21, 2017"))
			),
	
# TAB 3 - ORGANS
		tabPanel(
	# TAB TITLE 		
			"Add organ selection",
			tags$h1("Genomic Disorders Exploration!"),
			tags$h2("Add an additional organ involved"),
			tags$p("This page is for you to select an organ affected by the disorder."),
			
	# WELL PANEL + RADIOBUTTON
			wellPanel(
				selectInput(inputId = "organs_user_input", label = "Select an additional target organ involved (optional):", choices = 
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
					)
				),
		
				# Table depending on organs will only be displayed when click
			
		# ACTION BUTTON + MESSAGE + OUTPUT TABLE ORGANS
			tags$h4(
					"To make the table according to the phenotype feature entered initially\n
					and the target organ selected above \n
					(or to refresh the table if you changed the selected target organ)!"),		
	
			actionButton(inputId = "ready", label = "CLICK HERE"),
			tags$br(),		
			tags$br(),
			
			tags$h4(downloadButton("downloadData2", "Download"), align = "right"),
			
			DT::dataTableOutput(outputId = "syndromes_and_organs"),
		
			tags$br(),	
			tags$hr(),
		
			tags$h2("Sources/references of genomic data"),
			tags$h3("All data used in this app is publicly available"),
			tags$p("DECIPHER: Database of Chromosomal Imbalance and Phenotype in Humans using Ensembl Resources. Firth, H.V. et al (2009). Am.J.Hum.Genet 84, 524-533 (DOI: dx.doi.org/10/1016/j.ajhg.2009.03.010).\n
				A full list of centres who contributed to the generation of the data is available from http://decipher.sanger.ac.uk and via email from decipher@sanger.ac.uk. Funding for the project was provided by the Wellcome Trust."),
			tags$p("Gray KA, Yates B, Seal RL, Wright MW, Bruford EA. genenames.org: the HGNC resources in 2015. Nucleic Acids Res. 2015 Jan;43(Database issue):D1079-85. doi: 10.1093/nar/gku1071. PMID:25361968."),
			tags$p("HGNC Database, HUGO Gene Nomenclature Committee (HGNC), EMBL Outstation - Hinxton, European Bioinformatics Institute, Wellcome Trust Genome Campus, Hinxton, Cambridgeshire, CB10 1SD, UK www.genenames.org. Complete HGNC dataset downloaded", 
				tags$a("HERE", href = "https://www.genenames.org/cgi-bin/statistics")),
			tags$p("Orphanet: an online database of rare diseases and orphan drugs. Copyright, INSERM 1997. Available at http://www.orpha.net", tags$a("HERE", href = "http://www.orpha.net"), "(Accessed November 17, 2017)."),
			tags$p("Orphadata: Free access data from Orphanet. © INSERM 1997. Available on http://www.orphadata.org. Data version (XML data version en_product4_HPO.xml and en_product6.xml)."
			),
			wellPanel(tags$em("Author: My Linh Thibodeau"),
				tags$br(),
				tags$em(tags$a( "Open source code available on my Github" ,href= "https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw8-thibodeau-mylinh")),
			tags$br(),
			tags$em("Last updated November 21, 2017"))
			),

# TAB 4 - OVERVIEW
		tabPanel(
	# TAB TITLE		
			"Overview of source data",
			tags$h1("Overview of source data"),
	# PLOT ALLELIC 		
			tags$h3("Allelic requirement distribution in aggregated data"),
			plotOutput(outputId = "plot_summary_allelic"),
	# PLOT PHENOTYPE				
			tags$h3("Distribution of phenotypes frequencies"),
			colourInput("col", "Select colour", "purple"),
			plotOutput(outputId = "plot_summary_phenotype"),
	# PLOT ORGANS				
			tags$h3("Overview of organs affected distribution in aggregated data"),
			plotOutput(outputId = "plot_summary_organs"),
	# TABLE GENOTYPE - PHENOTYPE			
			tags$h3("Sample of gene-phenotype association"),
			tableOutput(outputId = "summary_phenotype_table"),
	# TABLE PHENOTYPE			
			tags$h3("Examples of phenotype choices"),
			tableOutput(outputId = "phenotype_choices_table"),
						
			tags$br(),
			tags$hr(),		
	
# SOURCE OF DATA - REFERENCES
			
			tags$h2("Sources/references of genomic data"),
			tags$h3("All data used in this app is publicly available"),
			tags$p("DECIPHER: Database of Chromosomal Imbalance and Phenotype in Humans using Ensembl Resources. Firth, H.V. et al (2009). Am.J.Hum.Genet 84, 524-533 (DOI: dx.doi.org/10/1016/j.ajhg.2009.03.010).\n
				A full list of centres who contributed to the generation of the data is available from http://decipher.sanger.ac.uk and via email from decipher@sanger.ac.uk. Funding for the project was provided by the Wellcome Trust."),
			tags$p("Gray KA, Yates B, Seal RL, Wright MW, Bruford EA. genenames.org: the HGNC resources in 2015. Nucleic Acids Res. 2015 Jan;43(Database issue):D1079-85. doi: 10.1093/nar/gku1071. PMID:25361968."),
			tags$p("HGNC Database, HUGO Gene Nomenclature Committee (HGNC), EMBL Outstation - Hinxton, European Bioinformatics Institute, Wellcome Trust Genome Campus, Hinxton, Cambridgeshire, CB10 1SD, UK www.genenames.org. Complete HGNC dataset downloaded", 
				tags$a("HERE", href = "https://www.genenames.org/cgi-bin/statistics")),
			tags$p("Orphanet: an online database of rare diseases and orphan drugs. Copyright, INSERM 1997. Available at http://www.orpha.net", tags$a("HERE", href = "http://www.orpha.net"), "(Accessed November 17, 2017)."),
			tags$p("Orphadata: Free access data from Orphanet. © INSERM 1997. Available on http://www.orphadata.org. Data version (XML data version en_product4_HPO.xml and en_product6.xml)."
			),
			wellPanel(tags$em("Author: My Linh Thibodeau"),
				tags$br(),
				tags$em(tags$a( "Open source code available on my Github" ,href= "https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw8-thibodeau-mylinh")),
				tags$br(),
				tags$em("Last updated November 21, 2017"))
			),
# TAB 5 - TUTORIAL		
		tabPanel(
		# TAB TITLE
			"Tutorial",
			tags$h1("Quick tutorial on how to use the app !"),
			
			tags$h4(tags$em("Welcome to the tutorial for my Genomic Disorders Exploration Shiny App")),
			
			tags$p("I decided to write a short tutorial to ease the understanding of this app."),
		# WHY
			tags$h3("Why this app?"),
			tags$p("I would like to make this app a useful tools for learning genomic disorders features!"),
			
			tags$h3("What kind of genomic data does the app use?"),
			tags$p("The app uses data from different resources (see at the end of this document for exact references):"),
	
			tags$ol(
				tags$li("DECIPHER: A database of chromosomal imbalances (deletion/duplication) associated with abnormal phenotype."),
				tags$li("HGNC (HUGO Gene Nomemclature Committee): Provides a standardized language to refer to human genes and also links to other genetic/genomic databases."),
				tags$li("Orphanet: A resource for phenotypic and clinical information on rare genetic disorders.")
				),

			tags$p("The main dataset used in this app is from the aggregation of the 3 above mentioned datasets. 
				Since it is based on the overlap between these datasets, it mainly contains Mendelian genomic disorders caused by chromosomal deletions/duplications 
				and it does not include the vast majority of disorders purely caused by other molecular mechanisms (e.g. triplet repeat expansion disorders, point mutations). 
				However, since some disorders can be caused by different types of of molecular mechanisms (e.g. neurofibromatosis can be caused by point mutations or more rarely, 
				by large deletions), some of these disorders may also be included in my app."),
			
		# WHAT	
			tags$h3("What does the app do?"),
			tags$p("The app has 5 tabs:"),
			tags$ol(
				tags$li("First tab: Phenotype and frequency - 
						It is meant for the user to enter  a phenotype and select the frequency of this phenotype, and then the app results the following data:",
						tags$strong("(A) Table with a list of syndromes (and associated characteristics if available, e.g. gene name)",
						"(B) Bar plot of the distribution of the mutation consequence types (syn. types of mutations) for this specific phenotype + frequency of phenotype combination.")),
				
					
				tags$li("Second tab: Checkout this box - It displays a tickbox, which when ticked, presents a drowdown menu of specific mutation consequence types. When the user select a choice, it will only diplay the genomic disorders corresponding to the 3 criteria: phenotype, frequency and specific mutation consequence."),
					
				tags$li("Third tab: Add organ selection - The user might have a large table when entering a common phenotype (e.g. intellectual disability + very frequent ~ 40 syndromes) and might want to refine his search further more by adding another organ system that is affected in this syndrome.",
					tags$strong("(A) The user needs to select an organ and then click on the \"CLICK HERE\" button to make the table appear. The new table will only contain syndromes that fulfill all 3 criteria: phenotype + frequency + additional organ system involed. For example, selecting \"Cancer predisposition\" reduce the list of syndromes from ~40 to one: pearlman syndrome."),
					tags$strong("(B) If no syndrome corresponds to the combination of the 3 criteria, the table will be empty.")),
			
				tags$li("Fourth tab: Overview of source data - Contains general summary plots/figures of the aggregated data used for the app."),
				tags$li("Fifth tab: Tutorial !"),
				tags$li("Sixth tab: Supplement - All phenotypes - Contains a table of all the possible phenotypes to enter")
				),
		
		# HOW		
			tags$h3("How to use the app?"),
			tags$p("Here is a stepwise approach to use the app:"),
			tags$ol(
				tags$li("Enter a phenotype (see next section for ideas of phenotypes to enter) and consult the table of syndromes and mutation consequence frequency."),
				tags$li("Move to the second tab and look at a subset of the table corresponding to the specific mutation consequence type."),
				tags$li("Move to the third tab and select an additional organ involved in the syndrome. Click on the \"CLICK HERE\" button to see a table of syndromes fulfilling all 3 criteria."),
				tags$li("Check out the fourth tab (overview of genomic data) to have an overview of the source data (aggregated data) and some sample data to get a general idea of the format of genomic data used in the app. "),
				tags$li("The fifth tab contains the tutorial information."),
				tags$li("Navigate to the sixth tab for a complete list of phenotypes.")
				),
	
		# PREMADE EXAMPLES	
			tags$h3("Here are \"premade\" scenarios for you to test my app"),
			
			tags$h4(tags$em("Scenario 1 - Intellectual disability")),
			tags$p("I described this scenario above, but let's break it down for ease:

				(1) Enter the phenotype \"intellectual disability\" and leave the frequency of feature at the default feature \"Very frequent (99-80%)\"
				(2) Navigate to second tab (Check out this checkbox) and select the \"activating\" mutation type to see a subset of interesting disorders.				
				(3) Navigate to third tab (Add organ selection) and select \"Cancer predisposition\"
				(4) Press the \"CLICK HERE\" button and see the resulting table.f As you can see you only have one hit now: pearlman syndrome."),
			
			tags$h4(tags$em("Scenario 2 - Cleft palate")),
			tags$p("
				(1) Enter the phenotype \"cleft palate\", but this time change the frequency to \"Occasional (29-5%)\" and browse the resulting table and plot.
				(2) Navigate to second tab (Check out this checkbox) and select the \"all missense/in frame\" mutation type to see interesting disorders.
				(3) Navigate to third tab (Add organ selection) and select \"Bone marrow failure\"
				(4) Press the \"CLICK HERE\" button and see the resulting table containing seven entities, many of which share a lot of phenotypic similarities. 
				This information is not in the table, I am providing it for your interest: The syndromes listed are part of the chromosomal breakage disorders group and they are complex disorders associated with multiple malformations and hematological involvement (not only bone marrow failure, but also hematological malignancies)."),
			
			tags$h4(tags$em("Scenario 3 - Skeletal dysplasia")),
			tags$p("
				(1) Enter the phenotype \"skeletal dysplasia\", but this time select the frequency to \"Frequent (79-30%)\".
				You will note that only one disorder, Neurofibromatosis type 1, frequently present skeletal dyplasia. 
				The reason is that skeletal dysplasias are caused by high penetrance mutations. These disorders are often in the \"all or nothing\" category. It is extremely rare to see an individual with one/two pathogenic mutation(s) (depending on inheritance) and no phenotype at all. If you change the frequency to \"Very frequent (99-80%)\", you will see a longer list of disorders.
				(2) Change the frequency back to \"Very frequent\" and navigate to second tab (Check out this checkbox) and select the \"dominant negative\" mutation type to see a subset of skeletal dysplasias !"),
			
			tags$h4(tags$em("Scenario 4 - Hearing impairment")),
			tags$p("
				(1) Enter the phenotype \"hearing impairment\" and leave the frequency of feature at the default feature \"Very frequent (99-80%)\".
				I have chosen this feature to illustrate that the full standardized Human Phenotype Ontology (HPO) phenotype name has to be entered in order for the app to work. I have not figured yet how to do \"contains the term\" yet.
				Therefore, entering \"hearing\" or \"hearing loss\" will not provide any results.
				(2) Navigate to third tab (Add organ selection) and select \"Heart/Cardiovasculature/Lymphatic\".
				(3) Press the \"CLICK HERE\" button and see the resulting table of some syndromes of interest."),
			
			tags$br(),
			tags$hr(),	
# SOURCE OF DATA - REFERENCES
			
			tags$h2("Sources/references of genomic data"),
			tags$h3("All data used in this app is publicly available"),
			tags$p("DECIPHER: Database of Chromosomal Imbalance and Phenotype in Humans using Ensembl Resources. Firth, H.V. et al (2009). Am.J.Hum.Genet 84, 524-533 (DOI: dx.doi.org/10/1016/j.ajhg.2009.03.010).\n
				A full list of centres who contributed to the generation of the data is available from http://decipher.sanger.ac.uk and via email from decipher@sanger.ac.uk. Funding for the project was provided by the Wellcome Trust."),
			tags$p("Gray KA, Yates B, Seal RL, Wright MW, Bruford EA. genenames.org: the HGNC resources in 2015. Nucleic Acids Res. 2015 Jan;43(Database issue):D1079-85. doi: 10.1093/nar/gku1071. PMID:25361968."),
			tags$p("HGNC Database, HUGO Gene Nomenclature Committee (HGNC), EMBL Outstation - Hinxton, European Bioinformatics Institute, Wellcome Trust Genome Campus, Hinxton, Cambridgeshire, CB10 1SD, UK www.genenames.org. Complete HGNC dataset downloaded", 
				tags$a("HERE", href = "https://www.genenames.org/cgi-bin/statistics")),
			tags$p("Orphanet: an online database of rare diseases and orphan drugs. Copyright, INSERM 1997. Available at http://www.orpha.net", tags$a("HERE", href = "http://www.orpha.net"), "(Accessed November 17, 2017)."),
			tags$p("Orphadata: Free access data from Orphanet. © INSERM 1997. Available on http://www.orphadata.org. Data version (XML data version en_product4_HPO.xml and en_product6.xml)."
			),
			wellPanel(tags$em("Author: My Linh Thibodeau"),
				tags$br(),
				tags$em(tags$a( "Open source code available on my Github" ,href= "https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw8-thibodeau-mylinh")),
				tags$br(),
				tags$em("Last updated November 21, 2017"))
		),

# TAB 6 ALL PHENOTYPES TABLE  				
		tabPanel(
			"Supplement - All phenotypes",
			DT::dataTableOutput(outputId = "all_phenotypes_choices"),
			tags$br(),	
			tags$hr(),
			
			tags$h2("Sources/references of genomic data"),
			tags$h3("All data used in this app is publicly available"),
			tags$p("DECIPHER: Database of Chromosomal Imbalance and Phenotype in Humans using Ensembl Resources. Firth, H.V. et al (2009). Am.J.Hum.Genet 84, 524-533 (DOI: dx.doi.org/10/1016/j.ajhg.2009.03.010).\n
				A full list of centres who contributed to the generation of the data is available from http://decipher.sanger.ac.uk and via email from decipher@sanger.ac.uk. Funding for the project was provided by the Wellcome Trust."),
			tags$p("Gray KA, Yates B, Seal RL, Wright MW, Bruford EA. genenames.org: the HGNC resources in 2015. Nucleic Acids Res. 2015 Jan;43(Database issue):D1079-85. doi: 10.1093/nar/gku1071. PMID:25361968."),
			tags$p("HGNC Database, HUGO Gene Nomenclature Committee (HGNC), EMBL Outstation - Hinxton, European Bioinformatics Institute, Wellcome Trust Genome Campus, Hinxton, Cambridgeshire, CB10 1SD, UK www.genenames.org. Complete HGNC dataset downloaded", 
				tags$a("HERE", href = "https://www.genenames.org/cgi-bin/statistics")),
			tags$p("Orphanet: an online database of rare diseases and orphan drugs. Copyright, INSERM 1997. Available at http://www.orpha.net", tags$a("HERE", href = "http://www.orpha.net"), "(Accessed November 17, 2017)."),
			tags$p("Orphadata: Free access data from Orphanet. © INSERM 1997. Available on http://www.orphadata.org. Data version (XML data version en_product4_HPO.xml and en_product6.xml)."
			),
			wellPanel(tags$em("Author: My Linh Thibodeau"),
				tags$br(),
				tags$em(tags$a( "Open source code available on my Github" ,href= "https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw8-thibodeau-mylinh")),
				tags$br(),
				tags$em("Last updated November 21, 2017"))
		)
	)
)