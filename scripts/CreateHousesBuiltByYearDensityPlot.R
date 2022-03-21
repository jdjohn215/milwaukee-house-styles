library(tidyverse)

# download MPROP from data.milwaukee.gov
current.mprop <- with_edition(1, read_csv("https://data.milwaukee.gov/dataset/562ab824-48a5-42cd-b714-87e205e489ba/resource/0a2c7f31-cd15-4151-8222-09dd57d5f16d/download/mprop.csv"))

# Just keep houses
houses <- current.mprop %>%
  filter(C_A_CLASS == 1, # residential class (excludes condos and apartment buildings)
         NR_UNITS > 0, # has at least 1 housing unit
         LAND_USE_GP %in% c(1,2,3), # single, duplex, or multi-family
         between(YR_BUILT, 1800, lubridate::year(Sys.Date()))) # drops invalid years
summary(houses$YR_BUILT)

# total number of still-standing houses built in each year
houses.by.year <- houses %>%
  group_by(YR_BUILT) %>%
  summarise(houses = n())

# make the basic plot
gg.year.built <- ggplot(houses, aes(YR_BUILT)) +
  geom_density(fill = "black") +
  geom_vline(xintercept = seq(1850, 2000, 50),
             color = "white", size = 0.1) +
  scale_x_continuous(breaks = seq(1850, 2000, 50),
                     labels = c("1850", "1900", "1950", "2000"),
                     name = "year built") +
  ggthemes::theme_tufte() +
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_rect(fill = "white", colour = "white"))
gg.year.built

# annotating a density plot is a bit complicated, because we have to identify
#   the y-value of the density curve at the given x-value (year) we wish to annotate.
#   First, extract the content of the ggplot object using ggplot::ggobj()
ggobj <- ggplot_build(gg.year.built)

plot.data <- tibble(ggobj$data[[1]]) # the dataframe used to construct the density curve

# some values I might want to annotate
pct.before.1900 <- (sum(houses.by.year$houses[houses.by.year$YR_BUILT < 1900])/sum(houses.by.year$houses))*100
pct.1920s <- ((sum(houses.by.year$houses[between(houses.by.year$YR_BUILT, 1920, 1929)]))/sum(houses.by.year$houses))*100
houses.1933 <- houses.by.year$houses[houses.by.year$YR_BUILT == 1933]
houses.1955 <- houses.by.year$houses[houses.by.year$YR_BUILT == 1955]
houses.1985 <- houses.by.year$houses[houses.by.year$YR_BUILT == 1985]
houses.2004 <- houses.by.year$houses[houses.by.year$YR_BUILT == 2004]
pct.postWWII <- ((sum(houses.by.year$houses[between(houses.by.year$YR_BUILT, 1946, 1965)]))/sum(houses.by.year$houses))*100

# the caption of the plot
caption.text <- paste("Milwaukee is", (max(houses.by.year$YR_BUILT) - 1846), "years old,",
                      "but over half its homes were built in just 30 years.",
                      str_to_title(english::as.english(pct.1920s)), "percent of",
                      "houses still standing in", max(houses.by.year$YR_BUILT),
                      "were built in the 1920s, and", paste0(round(pct.postWWII),"%"),
                      "were built in the post-WWII building boom from 1946-1965.")

# a convenience function for drawing arrow annotations for a given year (x-value)
#   it uses `plot.data` to find the y-value for a given x. Use the vertical and horizontal
#   parameters to change which way the arrow's tail points
arrow_annotate <- function(year, vertical = 0, horizontal = 0){
  yval <- mean(plot.data$y[round(plot.data$x) == year]) + .0005
  annotate("segment", x = year, y = yval,
           xend = (year + horizontal), yend = (yval + vertical),
           arrow = arrow(ends = "first", length = unit(0.1, "cm")))
}

# a convenience function for annotating the tail-end of an arrow drawn with arrow_annotate()
label_arrow <- function(year, label, vertical = 0, horizontal = 0, ...){
  yval <- mean(plot.data$y[round(plot.data$x) == year]) + .0005
  annotate("text", x = (year + horizontal), y = (yval + vertical),
           label = label, ... = ...)
}

# create a version of our plot with annotations and labels
gg.year.built.step2 <- gg.year.built +
  arrow_annotate(year = 1846, vertical = .001) +
  label_arrow(year = 1846, label = "Milwaukee is\nincorporated", vertical = .001,
              vjust = -0.1, size = 2.5) +
  arrow_annotate(year = 1900, vertical = .002, horizontal = -5) +
  label_arrow(year = 1900, label = str_wrap(paste(paste0(round(pct.before.1900),"%"),
                                                  "built before 1900"), 10),
              vertical = .002, vjust = -0.1, hjust = 1.5, size = 2.5) +
  arrow_annotate(year = 1925, vertical = .002, horizontal = -5) +
  label_arrow(year = 1925, label = str_wrap(paste(paste0(round(pct.1920s),"%"),
                                                  "built during the 1920s"), 15),
              vertical = .002, vjust = -0.1, hjust = 1.5, size = 2.5) +
  arrow_annotate(year = 1933, vertical = .004, horizontal = 1) +
  label_arrow(year = 1933, label = str_wrap(paste(prettyNum(houses.1933, ","),
                                                  "houses built in 1933"), 8),
              vertical = .004, vjust = -0.1, hjust = 0.2, size = 2.5) +
  arrow_annotate(year = 1955, vertical = 0, horizontal = 5) +
  label_arrow(year = 1955, label = str_wrap(paste(prettyNum(houses.1955, ","),
                                                  "houses built in 1955"), 15),
              vertical = -0.002, vjust = 0, hjust = -0.4, size = 2.5) +
  arrow_annotate(year = 2004, vertical = .001) +
  label_arrow(year = 2004, label = str_wrap(paste(houses.2004, "houses built in 2004"), 15),
              vertical = .001, vjust = -0.1, size = 2.5) +
  labs(title = "When Milwaukee's homes were built",
       subtitle = "only includes houses still standing in 2021, excludes apartment buildings and condos",
       caption = str_wrap(caption.text, 140))
gg.year.built.step2
ggsave("plots/BuiltByYear.svg", gg.year.built.step2, 
       width = 8, height = 4.5)
