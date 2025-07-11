# HexSim Results Processing: Multiple Species Model
# Dispersal Over Time: Rusty Crayfish
# cvaage@uw.edu

# Generates long form .csv file of range expansion/contraction over each time step

# SET-UP ----

library(dplyr)
library(tidyr)
library(tidyverse)


# LOAD DATA ----

# Add network file
net <- read_csv("data/spatial/jdr_sections.csv")
net <- net %>% 
  arrange(RID) %>% 
  select(RID, shape_leng) #shape_leng in meters


# PROCESSING ----

# Set source and destination files
input_folder <- "output/2_rc/2.2_rc_occupancy_ms"
output_folder <- "output/2_rc/2.6_rc_dispersal_ms"

# Make list of for loop files
file_list <- list.files(input_folder, full.names = TRUE)

counter <- 1

for(file in file_list){
  
  df <- read_csv(file)
  
  df <- merge(df, net, by = "RID")
  
  df_occ <- df %>% #sum total river length occupied (>1 individual) per time step
    group_by(Step) %>% 
    filter(Count >= 1) %>% 
    summarise(Extent_RM = sum(shape_leng, na.rm = TRUE)) %>% 
    mutate(Extent_RKM = Extent_RM/1000) %>% 
    select(Step, Extent_RKM)
  
  new_file_name <- paste0("/rc_dispersal_ms_", counter, ".csv")
  output_file <- paste0(output_folder, new_file_name)
  write.csv(df_occ, file = output_file, row.names = FALSE)
  
  counter <- counter + 1
  
}
