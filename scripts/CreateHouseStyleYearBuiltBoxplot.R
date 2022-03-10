library(tidyverse)

house.types <- read_csv("data/ParcelsWithBuildingTypes.csv") %>%
  filter(between(YR_BUILT, 1800, 2022)) %>%
  mutate(building_type = fct_reorder(building_type, YR_BUILT),
         building_type2 = fct_reorder(building_type2, YR_BUILT),
         building_type3 = fct_reorder(building_type3, YR_BUILT))

house.types %>% group_by(building_type) %>% summarise(count = n()) %>% arrange(desc(count))
house.types %>% group_by(building_type2) %>% summarise(count = n()) %>% arrange(desc(count))
house.types %>% group_by(building_type3) %>% summarise(count = n()) %>% arrange(desc(count))

boxplot.caption <- paste("This is a boxplot, also called a box-and-whisker plot.",
                         "For each box, the middle line shows the median.", 
                         "The upper and lower ends of the box are called hinges, &",
                         "they show the 25th and 75th percentiles.",
                         "The lines extending in both directions from the box are",
                         "the upper and lower whiskers. Each whisker extends toward the",
                         "largest or smallest value (respectively) which is no more",
                         "than 1.5 times the inter-quartile range from the hinge.",
                         "Any data points beyond a whisker are plotted individually",
                         "as outliers. The width of each box corresponds to the",
                         "relative number of observations in that category.")

hometypes.by.year <- house.types %>%
  filter(building_type3 %in% c("Ranch", "Cape Cod", "Residence old style",
                              "Old style duplex/triplex", "Bungalow",
                              "New style duplex/triplex", "Colonial",
                              "Cottage", "Townhouse", "Tudor", "Contemporary",
                              "Apartment building", "Condo multi-unit building")) %>%
  ggplot(aes(building_type3, YR_BUILT)) +
  geom_boxplot(varwidth = TRUE, outlier.alpha = 0.25, outlier.stroke = F) +
  scale_x_discrete(labels = function(x){str_wrap(x, width = 12)},
                   name = NULL) +
  ylab("year built") +
  labs(title = "Common Milwaukee housing types by year built",
       subtitle = "only includes buildings still standing in 2022",
       caption = str_wrap(boxplot.caption, 170)) +
  ggthemes::theme_tufte() +
  theme(plot.title.position = "plot")
hometypes.by.year
ggsave("plots/HomesTypesByYear.svg",
       hometypes.by.year, width = 9, height = 5)
