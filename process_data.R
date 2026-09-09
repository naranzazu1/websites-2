library(tidyverse)

billboard_long <- billboard |>
	pivot_longer(
		cols = starts_with("wk"),
		names_to = "week",
		names_prefix = "wk",
		values_to = "rank",
		values_drop_na = TRUE
	) |>
	mutate(week = as.integer(week))

top_tracks <- billboard_long |>
	group_by(artist, track) |>
	summarise(
		peak_rank = min(rank),
		weeks_on_chart = n(),
		.groups = "drop"
	) |>
	arrange(peak_rank, desc(weeks_on_chart)) |>
	slice_head(n = 8)

top_songs <- billboard_long |>
	inner_join(top_tracks, by = c("artist", "track")) |>
	mutate(track_label = str_c(track, " - ", artist))

write_rds(top_songs, file = "clean_data.rds")
