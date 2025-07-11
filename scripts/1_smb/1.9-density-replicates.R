# HexSim Results Processing: Smallmouth Bass Replicates
# Density Over Time: Single & Multiple Species Models
# cvaage@uw.edu

# Generates long form csv files of mean and sd density at reach scale

# SET-UP ----

library(dplyr)
library(tidyr)
library(tidyverse)


# PROCESSING: SINGLE SPECIES MODEL ----

# Set source and destination files
input_folder <- "output/1_smb/1.3_smb_density_ss"
output_folder <- "output/1_smb/3.4_replicates"

# List files from input folder
file_list <- list.files(path = input_folder, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE)

# Read in files and combine
combined_ss <- map2_dfr(file_list, seq_along(file_list),
                        ~ read_csv(.x) %>% mutate(Replicate = .y)) #adding replicate number

# Scale: Reach-level
# Compute mean and SD across replicates
summary_ss_r <- combined_ss %>%
  group_by(Step, RID) %>%
  summarise(
    Density_Mean = mean(Density_Adults),
    Density_SD = sd(Density_Adults),
    .groups = "drop")

# Export data file to output
write.csv(summary_ss_r, file = paste0(output_folder, "/smb_density_ss_reps.csv"), row.names = FALSE)


# PROCESSING: MULTIPLE SPECIES MODEL ----

# Set source and destination files
input_folder <- "output/1_smb/1.2_smb_occupancy_ms"
output_folder <- "output/1_smb/3.4_replicates"

# List files from input folder
file_list <- list.files(path = input_folder, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE)

# Read in files and combine
combined_ms <- map2_dfr(file_list, seq_along(file_list),
                        ~ read_csv(.x) %>% mutate(Replicate = .y)) #adding replicate number

# Scale: Reach-level
# Compute mean and SD across replicates
summary_ms_r <- combined_ms %>%
  group_by(Step, RID) %>%
  summarise(
    Density_Mean = mean(Density_Adults),
    Density_SD = sd(Density_Adults),
    .groups = "drop")

# Export data file to output
write.csv(summary_ms_r, file = paste0(output_folder, "/smb_density_ms_reps.csv"), row.names = FALSE)
