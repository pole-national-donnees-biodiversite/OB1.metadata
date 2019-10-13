# ui_import.R

source("import/import_functions.R")
source("import/server_import.R")

ui_import <- function(id) {
  ns <- NS(id)
  
  # basic look since ui.R is creating dashboard 
  fluidPage(
    fileInput(
      inputId = ns("file"), 
      label = "Choose CSV File",
      multiple = FALSE
    ),
    tableOutput(ns("contents")),
    radioButtons(
      inputId = ns("sep"), 
      label = "Separator",
      choices = c(Comma = ",",
                  Semicolon = ";",
                  Tab = "\t"),
      selected = ",")
  )
}
