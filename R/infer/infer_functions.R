# infer_functions.R

mimeTypes <- unique(gsub("/.*$", "", mimemap))

inferAudio <- function(filepath){
  print("audio")
}

inferImage <- function(filepath){
  print("image")
}

inferText <- function(filepath){
  print("text")
}