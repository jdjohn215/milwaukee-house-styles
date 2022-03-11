rm(list = ls())

library(tidyverse)

# download MPROP from data.milwaukee.gov
current.mprop <- read_csv("https://data.milwaukee.gov/dataset/562ab824-48a5-42cd-b714-87e205e489ba/resource/0a2c7f31-cd15-4151-8222-09dd57d5f16d/download/mprop.csv")

# building types
building.types <- read_csv("building-type-classification/BuildingTypeCodes.csv")
resi.building.types <- building.types %>%
  filter(!is.na(building_type2))

# Merge MPROP with codes, joining by BLDG_TYPE
d <- current.mprop %>%
  filter(NR_UNITS > 0, # must contain at least 1 housing unit
         LAND_USE_GP != 13 # must not be classified as vacant land
         ) %>%
  inner_join(resi.building.types) %>%
  # create address and face-block variables
  mutate(street_no = case_when(
    HOUSE_NR_HI == HOUSE_NR_LO ~ paste(HOUSE_NR_LO),
    TRUE ~ paste0(HOUSE_NR_LO, "-", HOUSE_NR_HI)
  ),
  address = paste(street_no, SDIR, STREET),
  address = ifelse(!is.na(STTYPE), paste(address, STTYPE), address),
  address = ifelse(!is.na(HOUSE_NR_SFX), paste(address, HOUSE_NR_SFX), address),
  face_block = paste(paste0(str_sub(HOUSE_NR_LO, 1, -3), "00"), SDIR, STREET),
  face_block = ifelse(!is.na(STTYPE), paste(face_block, STTYPE), face_block)) %>%
  select(TAXKEY, value = C_A_TOTAL, BLDG_AREA, NR_STORIES, NR_UNITS, YR_BUILT, face_block,
         address, building_type, building_type2, building_type3) %>%
  # Assign triplex building_supertype based on year of construction
  mutate(building_type3 = case_when(
    building_type3 != "[assign to old/new style duplex/triplex based on YR_BUILT]" ~ building_type3,
    YR_BUILT < 1945 ~ "Old style duplex/triplex",
    TRUE ~ "New style duplex/triplex"
  )) %>%
  # Assign C100 based on number of units
  mutate(building_type2 = case_when(
    building_type2 != "[specify apartment size group based on NR_UNITS]" ~ building_type2,
    NR_UNITS < 7 ~ "Apartments, 4-6 units",
    NR_UNITS < 12 ~ "Apartments, 7-11 units",
    NR_UNITS < 21 ~ "Apartments, 12-20 Units",
    TRUE ~ "Apartments, 21+ units"
  )) %>%
  ungroup()

d %>%
  group_by(building_type) %>%
  summarise(parcels = n(),
            median_year_built = median(YR_BUILT)) %>%
  arrange(-parcels) %>%
  print(n = 52)

d %>%
  group_by(building_type2) %>%
  summarise(parcels = n()) %>%
  arrange(-parcels) %>%
  print(n = 36)

d %>%
  group_by(building_type3) %>%
  summarise(parcels = n()) %>%
  arrange(-parcels) %>%
  print(n = 18)

write_csv(d, "data/ParcelsWithBuildingTypes.csv")
