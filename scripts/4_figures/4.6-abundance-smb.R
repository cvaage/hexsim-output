# HexSim Results Processing: Smallmouth Bass
# Abundance Over Time: Single vs. Multiple Species Models
# cvaage@uw.edu

#

# SET-UP ----

library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)


# READ IN DATA ----

ss <- read_csv("output/1_smb/3.4_replicates/smb_abundance_ss_s_reps.csv") #s for system-wide
ms <- read_csv("output/1_smb/3.4_replicates/smb_abundance_ms_s_reps.csv")

# Filter out future time steps
ss <- ss %>%
  filter(Step <= 312)
ms <- ms %>%
  filter(Step <= 312)

# PLOTTING PREP ----

# Define years for x-axis
plotbreaks <- seq(1, 312, by = 12)
plotlabels <- rep("", 25)
plotlabels[1] <- "2000"
plotlabels[6] <- "2005"
plotlabels[11] <- "2010"
plotlabels[16] <- "2015"
plotlabels[21] <- "2020"
plotlabels[26] <- "2025"

# Calculate yearly average (smoother trendline)
df_grouped <- ss %>%
  mutate(Year = ceiling(row_number() / 12)) %>%   # groups of 12 rows
  group_by(Year) %>%
  summarise(
    year_avg = mean(Mean, na.rm = TRUE),
    year_sd = mean(SD, na.rm = TRUE),
    .groups = "drop"
  )


# PLOTTING ----

ggplot(df_grouped, aes(x = Year, y = year_avg)) +
  geom_smooth(method = "loess", span = 0.2, se = FALSE, color = "grey20", size = 1) +
  geom_ribbon(aes(ymin = year_avg - year_sd, ymax = year_avg + year_sd), fill = "gray50", alpha = 0.5)

ggplot(ss, aes(x = Step, y = Mean)) +
  geom_smooth(method = "loess", span = 0.2, se = FALSE, color = "grey20", size = 1) +
  geom_ribbon(aes(ymin = Mean - SD, ymax = Mean + SD), fill = "gray50", alpha = 0.5) +
  #geom_line(color = "blue4", size = 1) +
  #geom_vline(xintercept = 120, color = "salmon", linetype = "dashed", linewidth = 1) +
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
  theme(axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.ticks = element_blank())

# EXPORT ----

ggsave("output/figure1.3b.png", plot = basssingle, width = 8, height = 8, dpi = 300)

