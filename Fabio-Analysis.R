#Data Analysis of DSC
## Date: 04/03/2023

## Loading the data
# TAsk:
# Find the ultimate strength (Mpa), Young's modolus (Mpa), Elongation at break (%), stress at yield .

# Load Libraries
library(tidyverse)
library(here)
library(readxl)
library(kableExtra)
library(ggpubr)
library(purrr)

# Loading data
sheets <- excel_sheets(path = "Data/20230222 - Catalina - traction.xls") # Names of the Sheets of the documents
sheets

# Parameters of the Tensile Test

Parameters <- read_excel(path = "Data/20230222 - Catalina - traction.xls", 
                         sheets[3] ,   skip = 0)

# Reading and creating a list from the Excel
data <- 
  sheets[4:97]  %>%  
  map( ~ read_excel(path = "Data/20230222 - Catalina - traction.xls", 
                    sheet = . ,   skip = 2)) %>%  # Reading the only data structure
  set_names(sheets[4:97])  %>%   enframe("Type", "Data")

#

## Create Tensile variable to start the analysis and Changing the Collumns names for each table
Tensile <-
  data %>%
  mutate(Data = 
           map(Data, ~ .x %>% set_names("Allongement", "Force",	"Temps", "Course", "Allongement_nominal")
           ))

## Calculating the Strength (not working yet)
## Adding variables to the Original data

Tensile <-
  Tensile %>%
  mutate(Data = map(Data, ~ .x %>%
                      mutate (Tensile = (Force / (5 * 13))*(1000),
                              Strain = Allongement_nominal / 60 )
  ))



### Function to identify Young's Modulus
Young_mod <- function(df) {
  # Filtering the Dataframe
  df <- df %>% filter(Strain >= 0.0005 & Strain <= 0.035 )
  # Doing the linear model
  model= lm(Tensile ~ Strain, data = df)
  E= coefficients(model)[[2]]
  return(E)
}

