  ggplot(diamonds,aes(x=carat, y=price, color = cut) ) +
    geom_jitter(color= "grey", alpha=0.1) +
    geom_rug(alpha=0.1) +
    geom_smooth(level=0.95) +
    facet_wrap(~ cut, nrow= 2) + 
    theme_bw()
