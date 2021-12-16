## Question 1
College.recoded <- College %>%
mutate (Private = ifelse(Private == "Yes", 1,0))
head(College.recoded)

## Question 2
lm.fit <- lm (Private ~ Apps + Accept + Enroll + Top10perc + Top25perc + F.Undergrad + P.Undergrad + Outstate + Room.Board + Books + Personal + PhD + Terminal + S.F.Ratio + perc.alumni + Expend + Grad.Rate,
           College.recoded)
summary (lm.fit)

## Question 3
lm.fit <- lm (Private ~ Outstate, College.recoded)
summary (lm.fit)

## Question 4
College.recoded %>%
ggplot(mapping = aes(x = Outstate, y = Private)) +
geom_point() +
geom_smooth(method = "lm")

## Question 5
lm.probs <- predict(lm.fit, type = "response")
College.recoded <- College.recoded %>%
  mutate(probs = lm.probs,
         pred = ifelse(probs > 0.5,1,0))
College.recoded %>%
  select(Private, pred) %>%
  table()
College.recoded %>%
  summarize(accuracy = mean(pred == Private))

## Question 6
lm.probs_multiple <- predict(lm.fit_multiple, type = "response")
College.recoded <- College.recoded %>%
  mutate(probs = lm.probs_multiple,
         pred = ifelse(probs > 0.5,1,0))
College.recoded %>%
  select(Private, pred) %>%
  table()
College.recoded %>%
  summarize(accuracy = mean(pred == Private))

## Question 7
glm.fit_multiple <- glm(Private ~ Apps + Accept + Enroll + Top10perc + Top25perc + F.Undergrad + P.Undergrad + Outstate + Room.Board + Books + Personal + PhD + Terminal + S.F.Ratio + perc.alumni + Expend + Grad.Rate,
                       College.recoded, family= "binomial")
summary (glm.fit_multiple)

## Question 8
glm.fit <- glm (Private ~ Outstate, College.recoded, family = "binomial")
summary (glm.fit)

## Question 9
College.recoded %>%
  ggplot(mapping = aes(x = Outstate, y = Private)) +
  geom_point() +
  geom_smooth(method = "glm", 
              method.args= c(family = "binomial"))

## Question 10
glm.probs <- predict(glm.fit, type = "response")
College.recoded <- College.recoded %>%
  mutate(probs = glm.probs,
         pred = ifelse(probs > 0.5,1,0))
College.recoded %>%
  select(Private, pred) %>%
  table()
College.recoded %>%
  summarize(accuracy = mean(pred == Private))

## Question 11
glm.probs_multiple <- predict(glm.fit_multiple, type = "response")
College.recoded <- College.recoded %>%
  mutate(probs = glm.probs_multiple,
         pred = ifelse(probs > 0.5,1,0))
College.recoded %>%
  select(Private, pred) %>%
  table()
College.recoded %>%
  summarize(accuracy = mean(pred == Private))

