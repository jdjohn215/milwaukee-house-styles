## Documentation for `ResidentialParcels_2021.csv`

*Please see `data/HomeStylesDocumentation.html` for descriptions of each building type.*

The file `ResidentialParcels_2021.csv` includes 1 row for each residential parcel (see discussion below) included in the MPROP file downloaded from data.milwaukee.gov on August 11, 2021. For each row it contains the following columns:

* **TAXKEY** - the unique identifier for every parcel, 10-digits
* **address** - each property's address, including the house number range and suffix, if applicable
* **year_built** - the `YR_BUILT` field from MPROP
* **value_2021** - the total 2021 assessed value for the entire property
* **building area** - the `BLDG_AREA` field from MPROP, area of the building in square feet
* **stories** - the `NR_STORIES` field from MPROP, number of stories in the building
* **building_type_code** - the original `BLDG_TYPE` from MPROP, derived from previous years when needed (see discussion below)
* **building_type** - the named values represented by the codes in `building_type_code`
* **building_type2** - same as `building_type` except `Residence Old Style` is broken out into three categories based on the number of stories in the building
  * Old style, 1-story
  * Old style, 1.5-story
  * Old style, 2-story (or more)
* **building_supertype** - same as `building_type2` with the following changes:
  * Cottages and Duplex Cottages are combined
  * Bungalows and Duplex Bungalows are combined
  * Triplexes are added to either Old or New Style Duplexes based on their year of construction
  * Split-levels and Bi-levels are combined with Ranch homes
* **x** - longitude in `crs = 32054`
* **y** - latitude in `crs = 32054`

### Data universe
This file includes all parcels from the MPROP file downloaded from data.milwaukee.gov on August 11, 2021 which met the following conditions:

* `C_A_CLASS == 1` - this includes residential properties, excluding apartment buildings and condominiums. It's true that some condominiums are actually located in "duplex" houses, but these are uncommon.
* `NR_UNITS > 0` - the parcel includes at least 1 housing unit
* `LAND_USE_GP %in% 1:3` - the land use assignment is one of single family home, duplex, or multi-family
  
### Assignment of BLDG_TYPE

If you download the [latest version](https://data.milwaukee.gov/dataset/mprop) of the MPROP file, you'll notice some new codes in the `BLDG_TYPE` field that aren't explained in the [provided documentation](https://data.milwaukee.gov/dataset/mprop/resource/15c1a935-ac7f-4d2f-8584-12bb9c1978c9). To identify useable codes for each parcel, I used an integrated version of the MPROP file containing each parcel's entries since 2008. I identified the most commonly used `BLDG_TYPE` value for each parcel during this period--provided that the MPROP record was created *after* the building in question was constructed.
