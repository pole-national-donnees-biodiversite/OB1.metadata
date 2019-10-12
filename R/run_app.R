#' Run the Shiny Application
#'
#' @export

#set working directory from actual file path
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#run shiny app
runApp()
