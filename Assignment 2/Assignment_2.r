## Question 1
flights %>%mutate(cancelled = is.na(dep_time),
hour=distance%/%100,
min=distance%/%100,
distance=hour+min/60)%>%
  ggplot(mapping=aes(x=Cancelled_Flights,y=Airport_Distance))+
  geom_boxplot(mapping=aes(x=cancelled, y=distance), size=.5, 
  notch=TRUE)

## Question 2
flights %>% group_by(month)
summarise(by_month,cancelled_proportions=mean(is.na(dep_time))) %>%
mutate(most_cancellations = ifelse(cancelled_proportions>0.03, T, F)) %>% 
ggplot(mapping = aes(x=as.factor(month), y=cancelled_proportions)) +
  geom_col(aes(fill = most_cancellations))+theme_bw()+
  scale_fill_manual(values = c('green', 'red'))       

## Question 3
flights %>% group_by(month, day) %>%
  summarise(distance_std=sd(distance),distance_m=mean(distance)) %>%
  ggplot(mapping=aes(x=distance_m,y=distance_std))+
  geom_smooth(method=lm)+geom_point()+theme_bw()
