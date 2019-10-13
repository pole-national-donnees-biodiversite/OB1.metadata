# infer.R

infer <- function(input, output, session,
                  savevar){
  ns <- session$ns
  
  savevar$infer <- reactiveValues()
  
  output$infer_ui <- renderUI({
    browser()
    mimeType <- mimeTypes[sapply(mimeTypes,
                                 grepl,
                                 guess_type(savevar$import$file$datapath)
    )]
    
    browser()
    return(
      switch(mimeType,
             # application = ,
             audio = inferAudio(savevar$import$file$datapath),
             # chemical = ,
             image = inferImage(savevar$import$file$datapath),
             # message = ,
             # model = ,
             text = inferText(savevar$import$file$datapath),
             # video = ,
             # `x-conference` = ,
             # `x-epoc` = ,
             # `x-world` = ,
             HTML("File is of unknown type or unloaded."))
    )
  })
  
  # output
  return(savevar)
}