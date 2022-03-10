## data/ParcelsWithBuildingTypes.csv

This file is built by running `scripts/FetchMPROP_IdentifyBuildingTypes.R`. That file:

1. Downloads the new MPROP file from data.milwaukee.gov
2. Creates face-block identifiers
3. Filters for only parcels containing housing units
4. Adds simplified building type codes documented in `/milwaukee-house-styles/`

It includes mixed commercial/residential buildings, houses which are currently being used for commercial purposes, and residential properties which are owned by tax-exempt organizations. It does **not** include group quarters housing like nursing homes, prisons, and group homes.