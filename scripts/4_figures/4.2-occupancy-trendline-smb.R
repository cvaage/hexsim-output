# HexSim Results Plotting
# Occupancy Over Time: SMB
# cvaage@uw.edu

# SET-UP ----

library(dplyr)
library(ggplot2)
library(tidyr)
library(tidyverse)


# LOAD DATA ----

# Add spatial data
net <- read.csv("data/spatial/jdr_sections.csv") #watershed sections (1-6)
net <- net[,c("RID", "shape_leng", "section")]
net <- net %>% 
  arrange(RID)

# Calculate total RKM per section
sects_total <- net %>% 
  group_by(section) %>% 
  summarise(totalrkm = sum(shape_leng))

# Add occupancy data
smb_occ_bw <- read.csv("output/3_both/3.1_smb_occupancy_basin.csv")
smb_occ_d_bw <- read.csv("output/3_both/3.2_smb_occupancy_difference_basin.csv")
smb_occ_sw <- read.csv("output/3_both/3.3_smb_occupancy_section.csv")
smb_occ_d_sw <- read.csv("output/3_both/3.4_smb_occupancy_difference_section.csv")


# REFORMAT ----

# Calculate proportion of section
colnames(sects_total) <- c("Section", "TotalRKM")
prop_plot <- left_join(smb_occ_sw, sects_total, by = "Section")
prop_plot$SS_Prop <- prop_plot$SS_RKM / prop_plot$TotalRKM
prop_plot$MS_Prop <- prop_plot$MS_RKM / prop_plot$TotalRKM
  
# Transform to long form
smb_occ_bw <- smb_occ_bw %>% 
  pivot_longer(cols = -c(Step),
               names_to = "Scenario",
               values_to = "Range")
smb_occ_sw <- smb_occ_sw %>% 
  pivot_longer(cols = -c(Step, Section),
               names_to = "Scenario",
               values_to = "Range")

# Change section values to names
smb_occ_sw$Section <- factor(smb_occ_sw$Section,
                             levels = 1:6,
                             labels = c("LM", "MM", "UM", "SF", "NF", "MF"))
smb_occ_d_sw$Section <- factor(smb_occ_d_sw$Section,
                               levels = 1:6,
                               labels = c("LM", "MM", "UM", "SF", "NF", "MF"))

prop_plot$Section <- factor(prop_plot$Section,
                             levels = 1:6,
                             labels = c("LM", "MM", "UM", "SF", "NF", "MF"))


# PLOTTING: SET-UP ----

plotbreaks <- seq(1, 312, by = 12)
plotlabels <- rep("", 26)
plotlabels[1] <- "2000"
plotlabels[6] <- "2005"
plotlabels[11] <- "2010"
plotlabels[16] <- "2015"
plotlabels[21] <- "2020"
plotlabels[26] <- "2025"


# PLOTTING ----

# Line plot showing trend RKM occupied between single and multiple species scenarios
ggplot(smb_occ_bw, aes(x = Step, y = Range, colour = Scenario)) +
  geom_line() +
  geom_vline(xintercept = 110, color = "salmon", linetype = "dashed", linewidth = 0.5) +
  theme(strip.background = element_rect(fill = NA, color = NA),
        panel.background = element_rect(fill=NA, color="gray60"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.spacing.x=unit(0, "lines"),
        panel.spacing.y=unit(0, "lines"),
        strip.text = element_blank()) +
  theme(axis.ticks = element_blank(),
        legend.position = "bottom") +
  scale_x_continuous(expand = c(0, 0),
                     breaks = plotbreaks,
                     labels = plotlabels) +
  scale_y_continuous(expand = c(0, 0),
                     limits = c(400,1000)) +
  labs(title = "River Extent Occupied by Smallmouth Bass",
       x = "Year", y = "River Kilometers Occupied")

# Line plot showing increasing difference in RKM occupied between single and multiple species scenarios
ggplot(smb_occ_d_bw, aes(x = Step, y = RKM_diff)) +
  geom_vline(xintercept = 110, color = "salmon", linetype = "solid", alpha = 0.3, linewidth = 20) +
  geom_hline(yintercept = 0, color = "grey60", linetype = "dotted", linewidth = 0.5) +
  geom_line(colour = "grey30") +
  theme(strip.background = element_rect(fill = NA, color = NA),
        panel.background = element_rect(fill=NA, color="grey60"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.spacing.x=unit(0, "lines"),
        panel.spacing.y=unit(0, "lines"),
        strip.text = element_blank()) +
  theme(axis.ticks = element_blank(),
        legend.position = "none") +
  scale_x_continuous(expand = c(0, 0),
                     breaks = plotbreaks,
                     labels = plotlabels) +
  scale_y_continuous(expand = c(0, 0)) +
  labs(title = "Difference in Smallmouth Bass Occupancy Between Model Scenarios",
       x = "Year", y = "RKM")

# Line plot showing increasing difference in RKM occupied between single and multiple species scenarios
ggplot(smb_occ_d_sw, aes(x = Step, y = RKM_diff, colour = Section)) +
  geom_smooth(method = "lm", se = FALSE) 

# Line plot showing increasing difference in RKM occupied between single and multiple species scenarios
ggplot(prop_plot, aes(x = Step, y = SS_Prop, colour = Section)) +
  geom_line() +
  geom_vline(xintercept = 120, color = "salmon", linetype = "dashed", linewidth = 0.5) +
  theme(strip.background = element_rect(fill = NA, color = NA),
        panel.background = element_rect(fill=NA, color="gray60"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.spacing.x=unit(0, "lines"),
        panel.spacing.y=unit(0, "lines"),
        strip.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  scale_x_continuous(expand = c(0, 0),
                     breaks = plotbreaks,
                     labels = plotlabels) + 
  scale_y_continuous(expand = c(0, 0)) +
  labs(title = "River Extent Occupied by Smallmouth Bass",
       x = "Year", y = "River Kilometers Occupied", color = "Section")


# EXPORT ----
ggsave()

