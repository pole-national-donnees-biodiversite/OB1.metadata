
source("import/server_import.R")

ui_import <- function(id) {
  ns <- NS(id)
  
  # basic look since ui.R is creating dashboard 
  fluidPage(
    fileInput(
      inputId = ns("file1"), 
      label = "Choose CSV File",
      multiple = FALSE
      ),
    radioButtons(
      inputId = ns("sep"), 
      label = "Separator",
      choices = c(Comma = ",",
                  Semicolon = ";",
                  Tab = "\t"),
      selected = ","),
    tableOutput(ns("contents"))
  )
}
