#Data Analysis of DSC
## Date: 05/01/2023

## Loading the data

# TAsk:
# Find the ultimate strength (Mpa), Young's modolus (Mpa), Elongation at break (%), stress at yield .


# Load Libraries
library(tidyverse)
library(here)
library(kableExtra)
library(ggpubr)
library (dbplyr)
library(stringr)
library(haven)

# AUX
library(DescTools) # https://search.r-project.org/CRAN/refmans/DescTools/html/AUC.html#:~:text=For%20linear%20interpolation%20the%20AUC,to%20calculate%20a%20numerical%20integral.

# Data Loading ----
## Loading the paths
files <- 
  here::here("Data") %>%
  dir( recursive=TRUE, full.names=TRUE, pattern="\\.csv$")


### Function to identify the names of the data ----
names <- 
  here::here("Data") %>%
  dir( recursive=TRUE, pattern="\\.csv$")
# Changing the names of the document

nombres <- Data[[4]]$...1 %>% na.omit()
nombres <- c("Inicial", "Parametros","stadisticas", nombres[1:45])

Data <- Data %>% set_names(nombres[1:48]) 

# use magrittr function to filter the list
Data <- Data %>% magrittr::extract(nombres[4:48]) # 

# PUtting the rigth names columns to each test
Data <- Data %>% map(~ .x %>% set_names("Allongement", "Force","Temps d'essai","Course standard", "Allongement nominal"))

# Deleting the first Three rowss  at each dataframe
Data <- Data %>% map(~ .x %>% slice(3:n()))

# Changing data as numeric to do stats
Data <- Data %>% map(~ .x %>% modify_if(is.character, as.double))

# Creating the Dataframe of Analisys
Data <- Data %>%   enframe("Sample", "Datos")

# Material and Code
Data$Material <- c(rep(c(  "M1",  "M2",  "M3" , "M4","M5","M6","M7","M8","M9","M13","M14", "M15", "M16", "M17","M18", "G1", "G2","G3","G4" ), each = 15) )
Data$Echantillon <- c( rep(LETTERS[1:5], each = 3),
                       rep( LETTERS[1:5], each = 3),
                       rep(LETTERS[1:5], each = 3))




files<- files %>% map( ~ read.csv2(.))
DSC <- DSC %>% set_names(names) %>% enframe ("Material", "Datos")
