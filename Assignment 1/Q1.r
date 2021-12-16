ggplot(diamonds,aes(x=carat, y=price) ) +
  geom_jitter(color= "grey", alpha=0.1) +
  facet_wrap(~ cut, nrow= 2) + 
  theme_bw()
