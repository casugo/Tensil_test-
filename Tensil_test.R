#Data Analysis of DSC
## Date: 05/01/2023

## Loading the data

# TAsk:
# Find the area under de curve (AUC) of the three materials and for each in the crystallinity
#   (ΔHc) (second set of data) and melting curve (ΔHm) (third set of data).
#   Explantion: when we perform a DSC test you have to heat the material in order to see the melting point, in this case,
#   BB (From -20 to 270 °C), rHDPE (20 - 250 °C) n rPET (20-270) (first set of data) . Then the
#   material is cold down with the inverse tempertures to see its crystallization (second set).
#   Finally, heated again to see the real melting point (third set of data).


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

files

### Function to identify the names of the data ----
names <- 
  here::here("Data") %>%
  dir( recursive=TRUE, pattern="\\.csv$")

DSC<- files %>% map( ~ read.csv2(.))
DSC <- DSC %>% set_names(names) %>% enframe ("Material", "Datos")
