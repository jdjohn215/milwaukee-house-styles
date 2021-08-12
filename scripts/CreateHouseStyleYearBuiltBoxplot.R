library(tidyverse)

house.types <- read_csv("data/ResidentialParcels_2021.csv") %>%
  filter(between(year_built, 1800, 2021)) %>%
  mutate(building_type = fct_reorder(building_type, year_built),
         building_type2 = fct_reorder(building_type2, year_built),
         building_supertype = fct_reorder(building_supertype, year_built))

house.types %>% group_by(building_type) %>% summarise(count = n()) %>% arrange(desc(count))
house.types %>% group_by(building_type2) %>% summarise(count = n()) %>% arrange(desc(count))
house.types %>% group_by(building_supertype) %>% summarise(count = n()) %>% arrange(desc(count))

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
  filter(building_type %in% c("Ranch", "Cape-Cod", "Residence old style",
                              "Duplex old style", "Milwaukee Bungalow",
                              "Bungalow duplex", "Duplex new style", "Colonial",
                              "Cottage", "Townhouse", "Duplex cottage", "Tudor")) %>%
  ggplot(aes(building_type, year_built)) +
  geom_boxplot(varwidth = TRUE, outlier.alpha = 0.25, outlier.stroke = F) +
  scale_x_discrete(labels = function(x){str_wrap(x, width = 12)},
                   name = NULL) +
  ylab("year built") +
  labs(title = "Common Milwaukee home types by year built",
       subtitle = "only includes houses still standing in 2021",
       caption = str_wrap(boxplot.caption, 170)) +
  ggthemes::theme_tufte() +
  theme(plot.title.position = "plot")
hometypes.by.year
ggsave("plots/HomesTypesByYear.svg",
       hometypes.by.year, width = 9, height = 5)
