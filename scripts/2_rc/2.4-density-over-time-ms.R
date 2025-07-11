# HexSim Results Processing: Multispecies Model
# Density Over Time: Rusty Crayfish
# cvaage@uw.edu

# Generates long form .csv file of occupant density (AGES 0-3) per reach at each time step 

# SET-UP ----

library(dplyr)
library(tidyr)
library(tidyverse)


# PROCESSING ----

# Set source and destination files
input_folder <- "data/multispecies"
output_folder <- "output/2_rc/2.4_rc_density_ms"

# List files from input folder
file_list <- list.files(path = input_folder, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE)
file_list <- file_list[grepl("monthly_rc", file_list)] #filter to 10 replicates

counter <- 1 #for file naming

# File processing
for(file in file_list){
  
  df <- read.csv(file) #read file
  
  df_long <- df %>% 
    select(Step, `Reach ID`, `Density [ cray ]`) %>% 
    rename(
      RID = "Reach ID",
      Density = "Density [ cray ]")
  
  cray_dens <- df_long %>% 
    mutate(
      Density_All = Density/10) %>% #divide back after using ceil() to output one decimal of precision
    select(Step, RID, Density_All)
  
  new_file_name <- paste0("/rc_density_ms_", counter, ".csv")
  output_file <- paste0(output_folder, new_file_name)
  write.csv(cray_dens, file = output_file, row.names = FALSE)
  
  counter <- counter + 1
}
