ggplot(data = diamonds,
       mapping = aes(x = cut, y = depth, fill = cut)) +
    geom_jitter(width = 0.2, color = "gray", alpha = 0.75) +
    geom_violin(alpha = 0.5, outlier.shape = NA) +
    theme_bw()
