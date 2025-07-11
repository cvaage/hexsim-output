# HexSim Results Plotting
# Occupancy Over Time: RC
# cvaage@uw.edu

# SET-UP ----
library(dplyr)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(sf)

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
rc_occ_bw <- read.csv("output/3_both/3.5_rc_occupancy_basin.csv")
rc_occ_d_bw <- read.csv("output/3_both/3.6_rc_occupancy_difference_basin.csv")
rc_occ_sw <- read.csv("output/3_both/3.7_rc_occupancy_section.csv")
rc_occ_d_sw <- read.csv("output/3_both/3.8_rc_occupancy_difference_section.csv")

# PLOTTING ----
plotbreaks <- seq(1, 300, by = 12)
plotlabels <- rep("", 25)
plotlabels[2] <- "2000"
plotlabels[7] <- "2005"
plotlabels[12] <- "2010"
plotlabels[17] <- "2015"
plotlabels[21] <- "2020"
plotlabels[25] <- "2025"

craysingle <- ggplot(rc_reps, aes(x = `Time Step`, y = Mean)) +
  geom_ribbon(aes(ymin = Mean - SD, ymax = Mean + SD),
              fill = "gray50",
              alpha = 0.5) +
  geom_line(color = "black", size = 1) +
  geom_vline(xintercept = 120, color = "salmon", linetype = "dashed", linewidth = 1) +
  theme(strip.background = element_rect(fill = NA, color = NA),
        panel.background = element_rect(fill=NA, color="gray60"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.spacing.x=unit(0, "lines"),
        panel.spacing.y=unit(0, "lines"),
        strip.text = element_blank()) +
  scale_x_continuous(expand = c(0, 0),
                     breaks = plotbreaks,
                     labels = plotlabels) + 
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Abundance") +
  xlab("Years") +
  theme(axis.title.x = element_text(size = 18, face = "bold"),
        axis.title.y = element_text(size = 18, face = "bold"),
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14))
craysingle
ggsave("output/figure1.3a.png", plot = craysingle, width = 8, height = 8, dpi = 300)

#both

rc_reps$Model <- "Single"
rc2_reps$Run <- 2
rc2_reps$Model <- "Multi"

crayboth <- rbind(rc_reps, rc2_reps)

craymulti <- ggplot(crayboth, aes(x = `Time Step`, y = Mean, group = Model)) +
  geom_ribbon(aes(ymin = Mean - SD, ymax = Mean + SD),
              fill = "gray50",
              alpha = 0.5) +
  geom_line(color = "black", size = 1) +
  geom_vline(xintercept = 120, color = "salmon", linetype = "dashed", linewidth = 1) +
  theme(strip.background = element_rect(fill = NA, color = NA),
        panel.background = element_rect(fill=NA, color="gray60"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.spacing.x=unit(0, "lines"),
        panel.spacing.y=unit(0, "lines"),
        strip.text = element_blank()) +
  scale_x_continuous(expand = c(0, 0),
                     breaks = plotbreaks,
                     labels = plotlabels) + 
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Abundance") +
  xlab("Years") +
  theme(axis.title.x = element_text(size = 18, face = "bold"),
        axis.title.y = element_text(size = 18, face = "bold"),
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14))
craymulti


# EXPORT ----

ggsave("output/figure1.3a.png", plot = craymulti, width = 8, height = 8, dpi = 300)
