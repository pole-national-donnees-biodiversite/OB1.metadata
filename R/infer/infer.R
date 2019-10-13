# infer.R

infer <- function(input, output, session,
                  savevar){
  ns <- session$ns
  
  savevar$infer <- reactiveValues()
  
  output$infer_ui <- renderUI({
    (out <- HTML("No file loaded"))
    req(savevar$import$file$datapath)
    mimeType <- mimeTypes[sapply(mimeTypes,
                                 grepl,
                                 guess_type(savevar$import$file$datapath)
    )]
    
    metadata <- switch(mimeType,
                  # application = ,
                  audio = inferAudio(savevar$import$file$datapath,
                                     savevar$infer),
                  # chemical = ,
                  image = inferImage(savevar$import$file$datapath),
                  # message = ,
                  # model = ,
                  text = inferText(savevar$import$file$datapath),
                  # video = ,
                  # `x-conference` = ,
                  # `x-epoc` = ,
                  # `x-world` = ,
                  HTML("File is of unknown type or unloaded.")
    )
    
    savevar$infer$metadata <- metadata
    
    out <- HTML("<b>Data type detected:</b> ", mimeType)
    out
  })
  
  # output
  return(savevar)
}