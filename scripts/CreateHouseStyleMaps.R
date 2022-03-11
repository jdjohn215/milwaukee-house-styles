library(tidyverse)
library(sf)
library(tmap)

parcels <- read_csv("data/ParcelsWithBuildingTypes.csv")
face.blocks <- st_read("housing_face_blocks/housing_face_blocks.shp")

# supplemental geographies, to be used in mapping
city.limits <- st_read("data/MilwaukeeCityLimits/MilwaukeeCityLimits.shp")
freeways <- st_read("data/MilwaukeeFreeways/MilwaukeeFreeways.shp")
water <- st_read("data/MilwaukeeWaterPolygons/MilwaukeeWaterPolygons.shp")
parks <- st_read("data/MilwaukeeParkPolygons/MilwaukeeParkPolygons.shp")

# totals for each home style in each face block
type.totals <- parcels %>%
  group_by(face_block) %>%
  mutate(total_parcels = n()) %>%
  group_by(face_block, total_parcels, building_type3) %>%
  summarise(count = n()) %>%
  ungroup() %>%
  mutate(pct = (count/total_parcels)*100)


# This function makes a small map of a given home type, or list of home types
map_hometype <- function(style, breaks = c(0, 10, 20, 30, Inf),
                         palette = c("#737373", "#525252", "#252525", "#000000")){
  map.data <- type.totals %>%
    filter(building_type3 %in% style) %>%
    group_by(face_block) %>%
    summarise(pct = sum(pct)) %>%
    inner_join(face.blocks) %>%
    mutate(pct = replace(pct, is.na(pct), 0)) %>%
    st_as_sf()
  tm_shape(city.limits) +
    tm_borders(col = "gray50", lwd = 2) +
    tm_shape(map.data) +
    tm_fill(col = "pct", breaks = breaks, palette = palette) +
    tm_shape(parks) +
    tm_fill(col = "darkgreen", alpha = 0.25) +
    tm_shape(freeways) +
    tm_lines(col = "darkgreen", alpha = 0.25, lwd = 2) +
    tm_shape(water) +
    tm_fill(col = "steelblue", alpha = 0.25) +
    tm_layout(frame = FALSE, main.title = paste(style, collapse = " and "),
              fontfamily = "serif", legend.show = FALSE)
}

parcels %>%
  group_by(building_type3) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

# includes cottages and duplex cottages
cottage.map <- map_hometype("Cottage")
tmap_save(cottage.map, "plots/Cottage_Type3_Map.png", height = 5)

# includes some triplexes
old.style.duplex.map <- map_hometype("Old style duplex/triplex")
tmap_save(old.style.duplex.map, "plots/OldStyleDuplex_Type3_Map.png", height = 5)

# includes duplex bungalows
bungalow.map <- map_hometype("Bungalow")
tmap_save(bungalow.map, "plots/Bungalow_Type3_Map.png", height = 5)

# Cape Cod
cape.cod.map <- map_hometype("Cape Cod")
tmap_save(cape.cod.map, "plots/CapeCod_Type3_Map.png", height = 5)

# Ranch, includes some bi- and split-level houses
ranch.map <- map_hometype("Ranch or multi-level")
tmap_save(ranch.map, "plots/Ranch_Type3_Map.png", height = 5)

# Colonial
colonial.map <- map_hometype("Colonial")
tmap_save(colonial.map, "plots/Colonial_Type3_Map.png", height = 5)

# Mansion
mansion.map <- map_hometype("Mansion")
tmap_save(mansion.map, "plots/Mansion_Type3_Map.png", height = 5)

# Tudor
tudor.map <- map_hometype("Tudor")
tmap_save(tudor.map, "plots/Tudor_Type3_Map.png", height = 5)

# Townhouse
townhouse.map <- map_hometype("Townhouse")
tmap_save(tudor.map, "plots/Townhouse_Type3_Map.png", height = 5)

# Condo multi-unit
condo.map <- map_hometype("Condos in multi-unit building")
tmap_save(condo.map, "plots/CondoMultiUnit_Type3_Map.png", height = 5)

# Apartment buildings
apartment.map <- map_hometype("Apartment building")
tmap_save(apartment.map, "plots/ApartmentBuilding_Type3_Map.png", height = 5)

# Apartments + commercial
apartment.commercial.map <- map_hometype("Apartments + commercial")
tmap_save(apartment.commercial.map, "plots/ApartmentCommercial_Type3_Map.png", height = 5)

# All apartments
apartment.all.map <- map_hometype(c("Apartments + commercial", "Apartment building"))
tmap_save(apartment.all.map, "plots/ApartmentAll_Type3_Map.png", height = 5)
