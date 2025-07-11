# HexSim Results Processing: Multispecies Model
# Occupancy Over Time: Rusty Crayfish
# cvaage@uw.edu

# Generates long form .csv file of number of individuals/floaters per reach at each time step 

# SET-UP ----

library(dplyr)
library(tidyr)
library(tidyverse)

# PROCESSING ---- 
# Set source and destination files
input_folder <- "data/multispecies"
output_folder <- "output/2_rc/2.2_rc_occupancy_ms"

# List files from input folder
file_list <- list.files(path = input_folder, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE)
file_list <- file_list[grepl("monthly_rc", file_list)] #filter to 10 replicates

counter <- 1

for(file in file_list){
  
  df <- readr::read_csv(file) #read file
  
  cray_month <- df %>% #rename columns for clarity
    rename(
      RID = "Reach ID",
      Temp = "Temperature [ actual ]",
      Area = "Reach Area",
      Occupants = "Occupants [ cray ]",
      Density = "Density [ cray ]",
      CrayT = "Temp [ cray proportion ]"
    )
  
  cray_count <- cray_month %>% #calculate occupants per reach per step
    group_by(Step, RID) %>% 
    summarise(Count = sum(Occupants))
  
  new_file_name <- paste0("/rc_occupancy_ms_", counter, ".csv")
  output_file <- paste0(output_folder, new_file_name)
  write.csv(cray_count, file = output_file, row.names = FALSE)
  
  counter <- counter + 1
}


