# HexSim Results Processing: Smallmouth Bass Replicates
# Abundance Over Time: Single vs. Multi Species Models
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

# Scale: System-level
# Compute mean and SD across replicates
summary_ss_s <- combined_ss %>%
  group_by(Step, Replicate) %>%
  summarise(total_count = sum(Count, na.rm = TRUE), .groups = "drop") %>%
  group_by(Step) %>%
  summarise(
    mean_total_count = mean(total_count),
    sd_total_count = sd(total_count),
    .groups = "drop")

# Compile into new data frame
clean_ss_s <- as.data.frame(matrix(nrow = 500, ncol = 3))
colnames(clean_ss_s) <- c("Step", "Mean", "SD")
clean_ss_s[,1] <- summary_ss_s$Step
clean_ss_s[,2] <- summary_ss_s$mean_total_count
clean_ss_s[,3] <- summary_ss_s$sd_total_count

# Scale: Reach-level
# Compute mean and SD across replicates
summary_ss_r <- combined_ss %>%
  group_by(Step, Replicate, RID) %>%
  summarise(total_count = sum(Count, na.rm = TRUE), .groups = "drop") %>%
  group_by(Step, RID) %>%
  summarise(
    mean_total_count = mean(total_count),
    sd_total_count = sd(total_count),
    .groups = "drop")

# Compile into new data frame
clean_ss_r <- as.data.frame(matrix(nrow = 1108500, ncol = 4))
colnames(clean_ss_r) <- c("Step", "RID", "Mean", "SD")
clean_ss_r[,1] <- summary_ss_r$Step
clean_ss_r[,2] <- summary_ss_r$RID
clean_ss_r[,3] <- summary_ss_r$mean_total_count
clean_ss_r[,4] <- summary_ss_r$sd_total_count

# Export data file to output
write.csv(clean_ss_s, file = paste0(output_folder, "/smb_abundance_ss_s_reps.csv"), row.names = FALSE)
write.csv(clean_ss_r, file = paste0(output_folder, "/smb_abundance_ss_r_reps.csv"), row.names = FALSE)


# PROCESSING: MULTIPLE SPECIES MODEL ----

# Set source and destination files
input_folder <- "output/1_smb/1.2_smb_occupancy_ms"
output_folder <- "output/1_smb/3.4_replicates"

# List files from input folder
file_list <- list.files(path = input_folder, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE)

# Read in files and combine
combined_ms <- map2_dfr(file_list, seq_along(file_list),
                        ~ read_csv(.x) %>% mutate(Replicate = .y)) #adding replicate number

# Scale: System-level
# Compute mean and SD across replicates
summary_ms_s <- combined_ms %>%
  group_by(Step, Replicate) %>%
  summarise(total_count = sum(Count, na.rm = TRUE), .groups = "drop") %>%
  group_by(Step) %>%
  summarise(
    mean_total_count = mean(total_count),
    sd_total_count = sd(total_count),
    .groups = "drop")

# Compile into new data frame
clean_ms_s <- as.data.frame(matrix(nrow = 500, ncol = 3))
colnames(clean_ms_s) <- c("Step", "Mean", "SD")
clean_ms_s[,1] <- summary_ms_s$Step
clean_ms_s[,2] <- summary_ms_s$mean_total_count
clean_ms_s[,3] <- summary_ms_s$sd_total_count

# Scale: Reach-level
# Compute mean and SD across replicates
summary_ms_r <- combined_ms %>%
  group_by(Step, Replicate, RID) %>%
  summarise(total_count = sum(Count, na.rm = TRUE), .groups = "drop") %>%
  group_by(Step, RID) %>%
  summarise(
    mean_total_count = mean(total_count),
    sd_total_count = sd(total_count),
    .groups = "drop")

# Compile into new data frame
clean_ms_r <- as.data.frame(matrix(nrow = 1108500, ncol = 4))
colnames(clean_ms_r) <- c("Step", "RID", "Mean", "SD")
clean_ms_r[,1] <- summary_ms_r$Step
clean_ms_r[,2] <- summary_ms_r$RID
clean_ms_r[,3] <- summary_ms_r$mean_total_count
clean_ms_r[,4] <- summary_ms_r$sd_total_count

# Export data file to output
write.csv(clean_ms_s, file = paste0(output_folder, "/smb_abundance_ms_s_reps.csv"), row.names = FALSE)
write.csv(clean_ms_r, file = paste0(output_folder, "/smb_abundance_ms_r_reps.csv"), row.names = FALSE)
