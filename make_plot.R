library(tidyverse)

top_songs <- read_rds("clean_data.rds")

billboard_plot <- top_songs |>
	ggplot(aes(x = week, y = rank, group = track_label, color = track_label)) +
	geom_line(linewidth = 1.2, alpha = 0.9) +
	geom_point(size = 2, alpha = 0.9) +
	scale_y_reverse() +
	scale_x_continuous(breaks = seq(1, 76, by = 5)) +
	scale_color_viridis_d(option = "magma", end = 0.9) +
	labs(
		title = "The Climb to Number One",
		subtitle = "Weekly Billboard rank for tracks that reached the top 10",
		x = "Weeks on the chart",
		y = "Billboard rank",
		color = "Track"
	) +
	theme_minimal(base_size = 12) +
	theme(
		plot.background = element_rect(fill = "#111827", color = NA),
		panel.background = element_rect(fill = "#111827", color = NA),
		panel.grid.minor = element_blank(),
		panel.grid.major = element_line(color = "#374151"),
		plot.title = element_text(color = "white", face = "bold", size = 20),
		plot.subtitle = element_text(color = "#d1d5db"),
		axis.title = element_text(color = "#d1d5db"),
		axis.text = element_text(color = "#9ca3af"),
		legend.background = element_rect(fill = "#111827", color = NA),
		legend.text = element_text(color = "#d1d5db"),
		legend.title = element_text(color = "white", face = "bold")
	)

ggsave("billboard.png", plot = billboard_plot)
