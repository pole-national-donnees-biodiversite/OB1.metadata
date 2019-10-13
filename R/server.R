#' @import shiny
app_server <- function(input, output,session) {
  session$onSessionEnded(stopApp)
  
  # Init var
  savevar <- reactiveValues()
  
  # Dev
  observeEvent(input$dev, {
    browser()
  })
  
  # Modules ----
  callModule(server_import,"import_mod", savevar)
  callModule(infer, "infer_mod", savevar)
  callModule(semantics, "semantics_mod", savevar)
}
