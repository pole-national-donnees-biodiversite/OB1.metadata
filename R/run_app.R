setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
#' Run the Shiny Application
#'
#' @export
library(shinydashboard)
source("semantics/semanticsUI.R")
#set working directory from actual file path

#run shiny app
runApp(".")