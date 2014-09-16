library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Extracter"),
  
  sidebarLayout(
    sidebarPanel( 
      # Main parameters:
      checkboxInput(inputId="showHelp", "Show help", value = FALSE),
      conditionalPanel(
        condition = "input.showHelp == true",
        helpText(HTML("<div style=\"text-indent: 25px\">Provide your 16S database, forward & reverse primer sequences, output prefix. Output file will be named as: 'output prefix.fasta'.
                       By default, output file is stored in the same program directory if it is not defined in output prefix.</div>"))
      
      ),
      fileInput(inputId="file", "16S database", multiple = FALSE, accept = NULL),
      textInput(inputId="forward_primer", "Forward primer sequence", value = "NGAGTTTGATCCTGGCTCAG"),
      textInput(inputId="reverse_primer", "Reverse primer sequence", value = "ATTACCGCGGCTGCTGG"),
      textInput(inputId="output_prefix", "Output prefix", value = "test"),
      
      # Advanced parameters:
      checkboxInput(inputId="advanced_parameters", "Advanced parameters", value = FALSE),
      conditionalPanel(
        condition = "input.advanced_parameters == true",
        helpText(HTML("<div style=\"text-indent: 25px\">Change these default parameters if application can't find forward and/or reverse primets (which leads to zeros in a summary table)</div>")),
        numericInput("match_award", label = "Match award", value = 2),
        numericInput("mismatch_penalty", label = "Mismatch penalty", value = -5),
        numericInput("gap_open", label = "Gap open penalty", value = -8)
      ),
      br(),
      
      # Compute button:
      actionButton("startButton", "Start computation")
    ),
    mainPanel(
      textOutput("controlText"),
      br(),
      tableOutput("statistics"),
      br(),
      textOutput("outputFiles")
    )
  )
))