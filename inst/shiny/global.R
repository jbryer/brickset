library(shiny)
library(DT)
library(brickset)
library(dplyr)

data(legosets, package = 'brickset')

default_view_cols <- c('setID','name','year','theme','released','pieces','minifigs','availability','US_retailPrice')
