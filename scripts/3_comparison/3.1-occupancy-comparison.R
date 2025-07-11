# HexSim Results Processing: Model Comparison
# Differences in Occupancy Over Time: Single vs. Multiple Species
# cvaage@uw.edu

# Generates .csv files(8) of differences in occupancy between single & multiple species models by system & section over each time step

# SET-UP ----

library(dplyr)
library(tidyr)
library(tidyverse)


# LOAD DATA ----

# Add spatial data
net <- read_csv("data/spatial/jdr_sections.csv") #watershed sections (1-6)
net <- net[,c("RID", "shape_leng", "section")]
net <- net %>% 
  arrange(RID)

# Add single species model averages
bass_ss <- read_csv("output/1_smb/3.4_replicates/smb_occupancy_ss_reps.csv") #SMB
cray_ss <- read_csv("output/2_rc/3.4_replicates/rc_occupancy_ss_reps.csv") #RC

# Add multiple species model averages
bass_ms <- read_csv("output/1_smb/3.4_replicates/smb_occupancy_ms_reps.csv") #SMB
cray_ms <- read_csv("output/2_rc/3.4_replicates/rc_occupancy_ms_reps.csv") #RC

# Combine by time step & RID
bass <- left_join(bass_ss, bass_ms, by = c("Step", "RID"))
cray <- left_join(cray_ss, cray_ms, by = c("Step", "RID"))
colnames(bass) <- c("Step", "RID", "n_reps_SS", "n_reps_MS") #rename cols
colnames(cray) <- c("Step", "RID", "n_reps_SS", "n_reps_MS") #rename cols


# QUALITY CONTROL ----

n_distinct(bass_ss$Step) #all should = 312/500
n_distinct(bass_ms$Step)
n_distinct(cray_ss$Step)
n_distinct(cray_ms$Step)

bass_temp <- bass %>% #temporary cut off #######################################
  filter(Step <= 270)

# Clean up
rm(bass_ms, bass_ss,
   cray_ms, cray_ss)


# ANALYSES: BASIN-WIDE ----

bassBW <- left_join(bass_temp, net, by = "RID") ##################change to bass
crayBW <- left_join(cray, net, by = "RID")

# A - Total river occupied ####

# SMB
bassAss <- bassBW[,c("Step", "RID", "n_reps_SS", "shape_leng")] #single species model
bassAss <- bassAss %>% 
  filter(n_reps_SS >= 1) %>% 
  group_by(Step) %>%
  summarise(RM = sum(shape_leng, na.rm = TRUE)) %>% 
  mutate(RKM = RM/1000)

bassAms <- bassBW[,c("Step", "RID", "n_reps_MS", "shape_leng")] #multispecies model
bassAms <- bassAms %>% 
  filter(n_reps_MS >= 1) %>% 
  group_by(Step) %>%
  summarise(RM = sum(shape_leng, na.rm = TRUE)) %>% 
  mutate(RKM = RM/1000)

bassA <- left_join(bassAss, bassAms, by = "Step")
colnames(bassA) <- c("Step", "SS_RM", "SS_RKM", "MS_RM", "MS_RKM")

# RC
crayAss <- crayBW[,c("Step", "RID", "n_reps_SS", "shape_leng")] #single species model
crayAss <- crayAss %>% 
  filter(n_reps_SS >= 1) %>% 
  group_by(Step) %>%
  summarise(RM = sum(shape_leng, na.rm = TRUE)) %>% 
  mutate(RKM = RM/1000)

crayAms <- crayBW[,c("Step", "RID", "n_reps_MS", "shape_leng")] #multispecies model
crayAms <- crayAms %>% 
  filter(n_reps_MS >= 1) %>% 
  group_by(Step) %>%
  summarise(RM = sum(shape_leng, na.rm = TRUE)) %>% 
  mutate(RKM = RM/1000)

crayA <- left_join(crayAss, crayAms, by = "Step")
colnames(crayA) <- c("Step", "SS_RM", "SS_RKM", "MS_RM", "MS_RKM")


# B - Difference in river occupied ####

# SMB
bassB <- bassA %>% 
  group_by(Step) %>% 
  mutate(RM_diff = SS_RM - MS_RM) %>% 
  mutate(RKM_diff = SS_RKM - MS_RKM)
bassB <- bassB[,c("Step", "RM_diff", "RKM_diff")]

# RC
crayB <- crayA %>% 
  group_by(Step) %>% 
  mutate(RM_diff = SS_RM - MS_RM) %>% 
  mutate(RKM_diff = SS_RKM - MS_RKM)
crayB <- crayB[,c("Step", "RM_diff", "RKM_diff")]

# Clean up
rm(bassAms, bassAss, crayAms, crayAss)


# ANALYSES: BASIN-SECTIONS ----

bassBS <- left_join(bass_temp, net, by = "RID") ##################change to bass
crayBS <- left_join(cray, net, by = "RID")

# C - Total river occupied ####

# SMB
bassCss <- bassBS[,c("Step", "RID", "SS", "shape_leng", "section")] #single species model
bassCss <- bassCss %>% 
  filter(SS >= 1) %>% 
  group_by(Step, section) %>%
  summarise(RM = sum(shape_leng, na.rm = TRUE)) %>% 
  mutate(RKM = RM/1000)
bassCms <- bassBS[,c("Step", "RID", "MS", "shape_leng", "section")] #multispecies model
bassCms <- bassCms %>% 
  filter(MS >= 1) %>% 
  group_by(Step, section) %>%
  summarise(RM = sum(shape_leng, na.rm = TRUE)) %>% 
  mutate(RKM = RM/1000)
bassC <- left_join(bassCss, bassCms, by = c("Step", "section"))
colnames(bassC) <- c("Step", "Section", "SS_RM", "SS_RKM", "MS_RM", "MS_RKM")

# RC
crayCss <- crayBS[,c("Step", "RID", "SS", "shape_leng", "section")] #single species model
crayCss <- crayCss %>% 
  filter(SS >= 1) %>% 
  group_by(Step, section) %>%
  summarise(RM = sum(shape_leng, na.rm = TRUE)) %>% 
  mutate(RKM = RM/1000)
crayCms <- crayBS[,c("Step", "RID", "MS", "shape_leng", "section")] #multispecies model
crayCms <- crayCms %>% 
  filter(MS >= 1) %>% 
  group_by(Step, section) %>%
  summarise(RM = sum(shape_leng, na.rm = TRUE)) %>% 
  mutate(RKM = RM/1000)
crayC <- left_join(crayCss, crayCms, by = c("Step", "section"))
colnames(crayC) <- c("Step", "Section", "SS_RM", "SS_RKM", "MS_RM", "MS_RKM")


# D - Difference in river occupied ####

# SMB
bassD <- bassC %>% 
  group_by(Step, Section) %>% 
  mutate(RM_diff = SS_RM - MS_RM) %>% 
  mutate(RKM_diff = SS_RKM - MS_RKM)
bassD <- bassD[,c("Step", "Section", "RM_diff", "RKM_diff")]

# RC
crayD <- crayC %>% 
  group_by(Step, Section) %>% 
  mutate(RM_diff = SS_RM - MS_RM) %>% 
  mutate(RKM_diff = SS_RKM - MS_RKM)
crayD <- crayD[,c("Step", "Section", "RM_diff", "RKM_diff")]


# EXPORT ----

# SMB
write.csv(bassA, "output/3_both/3.1_smb_occupancy_basin.csv", row.names = FALSE)
write.csv(bassB, "output/3_both/3.2_smb_occupancy_difference_basin.csv", row.names = FALSE)
write.csv(bassC, "output/3_both/3.3_smb_occupancy_section.csv", row.names = FALSE)
write.csv(bassD, "output/3_both/3.4_smb_occupancy_difference_section.csv", row.names = FALSE)

# RC
write.csv(crayA, "output/3_both/3.5_rc_occupancy_basin.csv", row.names = FALSE)
write.csv(crayB, "output/3_both/3.6_rc_occupancy_difference_basin.csv", row.names = FALSE)
write.csv(crayC, "output/3_both/3.7_rc_occupancy_section.csv", row.names = FALSE)
write.csv(crayD, "output/3_both/3.8_rc_occupancy_difference_section.csv", row.names = FALSE)
