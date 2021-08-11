library(tidyverse)
library(sf)

# This script:
#   1) retrieves the parcel polygons
#   2) filters for residential parcels (C_A_CLASS == 1)
#   3) creates a face-block variable, e.g. the block "100 N 1ST ST"
#   4) summaries the parcel polygons to larger face-block polygons,
#       made up of just the residential polygons on each block

# This might take a few minutes to download
parcels <- st_read("https://milwaukeemaps.milwaukee.gov/arcgis/rest/services/property/parcels_mprop/MapServer/2/query?returnGeometry=true&where=1=1&outFields=*&f=geojson")

blocks <- parcels %>%
  # construct face-block variable
  mutate(block_number = paste0(str_sub(HOUSE_NR_LO, 1, -3), "00"),
         face_block = paste(block_number, SDIR, STREET),
         face_block = ifelse(!is.na(STTYPE), paste(face_block, STTYPE), face_block)) %>%
  filter(C_A_CLASS == 1) %>% # just keep residential
  group_by(face_block) %>%
  summarise()

st_write(blocks, "residential_face_blocks/residential_face_blocks.shp")
