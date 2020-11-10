ggplot(plot.data, aes(carat, price)) +
    geom_point(aes(color = clarity)) +
    labs(
        title = "Chart Title",
        subtitle = "Chart Subtitle",
        caption = "Chart Caption"
    ) +
scale_x_continuous(name = "Size in Carats") +
scale_y_continuous(
    name = "Price ($)",
    labels = dollar_format()
) +
theme_minimal() +
theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    plot.caption = element_text(hjust = 1)
)