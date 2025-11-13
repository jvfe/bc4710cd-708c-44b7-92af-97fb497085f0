library(ggplot2)
library(dplyr)
library(tidyr)
library(ggsignif)

plot_data <- readr::read_csv("extracted_solution.csv")

# (a) Shannon: T-test
shannon_test <- t.test(Shannon_index ~ Group, data = plot_data)
shannon_label <- paste("T-test, p value =", round(shannon_test$p.value, 3))

plot_colors <- c("Control" = "cornflowerblue", "COPD" = "orange")

# (a) Shannon Plot
y_pos_a <- max(plot_data$Shannon_index) * 1.05 # Position for stat label
p_shannon <- ggplot(plot_data, aes(x = Group, y = Shannon_index)) +
  geom_boxplot(aes(fill = Group), outlier.shape = NA, alpha = 0.7) +
  geom_jitter(aes(color = Group), width = 0.25, alpha = 0.8) +
  scale_fill_manual(values = plot_colors) +
  scale_color_manual(values = plot_colors) +
  labs(y = "Shannon index", x = NULL, tag = "(a)") +
  theme_bw() +
  theme(legend.position = "none",
        plot.tag = element_text(face = "bold")) +
  geom_signif(comparisons = list(c("Control", "COPD")),
              annotations = shannon_label,
              y_position = y_pos_a,
              tip_length = 0.01)

final_figure <- p_shannon

print(final_figure)

ggsave("extracted_solution.jpg", final_figure,
      width = 4, height = 4, dpi = 300)
