# HexSim Results Processing: Smallmouth Bass Replicates
# Occupancy Over Time: Single & Multiple Species Models
# cvaage@uw.edu

# Generates long form csv files of mean and sd abundance at system(1,3) and reach scales(2,4)

# SET-UP ----

library(dplyr)
library(tidyr)
library(tidyverse)


# PROCESSING: SINGLE SPECIES MODEL ----

# Set source and destination files
input_folder <- "output/1_smb/1.1_smb_occupancy_ss"
output_folder <- "output/1_smb/3.4_replicates"

# List files from input folder
file_list <- list.files(path = input_folder, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE)

# Read in files and combine
combined_ss <- map2_dfr(file_list, seq_along(file_list),
                        ~ read_csv(.x) %>% mutate(Replicate = .y)) #adding replicate number

# Calculate number of replicates with SMB present in each reach
summary_ss <- combined_ss %>%
  group_by(Step, RID) %>%
  summarise(n_replicates_present = sum(Count > 0),
            .groups = "drop")

# Export data file to output
write.csv(summary_ss, file = paste0(output_folder, "/smb_occupancy_ss_reps.csv"), row.names = FALSE)


# PROCESSING: MULTIPLE SPECIES MODEL ----

# Set source and destination files
input_folder <- "output/1_smb/1.2_smb_occupancy_ms"
output_folder <- "output/1_smb/3.4_replicates"

# List files from input folder
file_list <- list.files(path = input_folder, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE)

# Read in files and combine
combined_ms <- map2_dfr(file_list, seq_along(file_list),
                        ~ read_csv(.x) %>% mutate(Replicate = .y)) #adding replicate number

# Calculate number of replicates with SMB present in each reach
summary_ms <- combined_ms %>%
  group_by(Step, RID) %>%
  summarise(n_replicates_present = sum(Count > 0),
            .groups = "drop")

# Export data file to output
write.csv(summary_ms, file = paste0(output_folder, "/smb_occupancy_ms_reps.csv"), row.names = FALSE)
