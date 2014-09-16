library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Create an environment for storing data
  values <- reactiveValues()
  
  
  #This function is repsonsible for loading in the selected file
  filedata <- reactive({
    infile <- input$file
    if (is.null(infile)) {
      # User has not uploaded a file yet
      values[["done"]] <- 0
      return(NULL)
    }
    print(infile)
    ans <- infile$datapath
  })
  
  output$controlText <- renderText({
  #compute <- reactive({
    input$startButton
    values[["done"]] <- 0
    isolate({
      df <-filedata()
      if (is.null(df)) {
        return("No input file")
      } else {
        values[["done"]] <- 0
        fp <- input$forward_primer
        rp <- input$reverse_primer
        out_prefix <- input$output_prefix
        ma <- input$match_award
        mp <- input$mismatch_penalty
        gap <- input$gap_open
        python_path <- "/Library/Frameworks/Python.framework/Versions/2.7/Resources/Python.app/Contents/MacOS/Python"
        print("In progress...")
        system(paste(python_path, "extract.py", df, out_prefix, "--fp", fp, "--rp", rp, "-m", toString(ma), "-p", toString(mp), "-g", toString(gap)))
        infile <- paste(input$output_prefix, ".txt",sep='')
        values[["table"]] <- read.table(infile, header=T,sep='\t')
        values[["done"]] <- 1
        print("Done!")
      }
    })
  })
    
    output$statistics <- renderTable({
      load_statistics()
    })
    
    # Parsing output statistics:
    load_statistics <- reactive({
      df <-filedata()
      if (is.null(df)) {
        return(NULL)
      }
      
      values[["table"]]
      
    })
  
  output$outputFiles <- renderText({
    df <-filedata()
    if (is.null(df)) {
      return(NULL)
    }
    
    print(paste("Output file: ", input$output_prefix, ".fasta", sep=''))
  })
})
