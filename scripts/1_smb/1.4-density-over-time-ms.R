# HexSim Results Processing: Multispecies Model
# Density Over Time: Smallmouth Bass
# cvaage@uw.edu

# Generates long form .csv file of occupant density (AGES 1-6) per reach at each time step 

# SET-UP ----

library(dplyr)
library(tidyr)
library(tidyverse)


# PROCESSING ----

# Set source and destination files
input_folder <- "data/multispecies"
output_folder <- "output/1_smb/1.4_smb_density_ms"

# List files from input folder
file_list <- list.files(path = input_folder, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE)
file_list <- file_list[grepl("density_smb", file_list)] #filter to 10 replicates

counter <- 1 #for file naming
rids <- seq(0, 2216, by = 1) #for appending back to df
steps <- seq(1, 312, by = 1) #renaming columns
steps <- c("RID", as.character(steps))

# File processing
for(file in file_list){
  
  df <- read.csv(file) #read file
  
  df_even <- df[ , seq(2, ncol(df), by = 2)] #remove every other column (2,4,6...)
  df_even <- df[,c(1:313)] #isolate time frame of interest
  
  colnames(df_even) <- steps #rename time step headers
  
  df_long <- df_even %>%
    pivot_longer(
      cols = -RID, #all columns except reach_id
      names_to = "Step", #new column for former column names
      values_to = "Density" #new column for values
    )
  
  bass_dens <- df_long %>% 
    mutate(
      Density_Adults = Density/10) %>% #divide back after using ceil() to output one decimal of precision
    select(Step, RID, Density_Adults)
  
  new_file_name <- paste0("/smb_density_ms_", counter, ".csv")
  output_file <- paste0(output_folder, new_file_name)
  write.csv(bass_dens, file = output_file, row.names = FALSE)
  
  counter <- counter + 1
}
