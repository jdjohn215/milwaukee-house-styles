# milwaukee-house-styles

Like a tree, Milwaukee's residential neighborhoods spread in concentric rings around the downtown commercial core. Each layer preserves a distinctive swathe of homes, bearing witness to the way a generation of Milwaukeens lived and worked, all while likewise shaping the way every subsequent generation experiences their city.

--------------------------------------------------------------------------------
**Please note:** A previous version of the repository focused exclusively on "residential properties" (`C_A_CLASS == 1`). The repository has been updated to incorporate additional information added by the Assessor's Office in recent years.

--------------------------------------------------------------------------------
**Condominiums**

Condominiums are a special case. Technically, calling something a "condo" simply describes its ownership structure and nothing about the kind of building. Sometimes townhouses, duplexes, etc. are "condo-ized." There are many duplexes in Milwaukee which technically consist of two separate legal condominium units. In all these cases, I have coded to the condo to the physical building's architectural style.

Other condos are located in multi-unit buildings. I have classified these as "Condos in multi-unit buildings." A word of caution: each condo unit has its own TAXKEY, so a single building containing 40 condo units appears 40 times in the data. By contrast, an apartment building with 40 units appears just once. 

--------------------------------------------------------------------------------

The Milwaukee Assessor's Office maintains an extensive database of property records. They assign one of a list of architectural styles to each house in Milwaukee. This repo shows ways of using this data.

The core parcel-level data is in `data/ParcelsWithBuildingTypes.csv`. See the [README](/data/) for details and documentation.

Read the City Assessor's definitions of each home style in the [building type README](/building-type-classification/).

One good way to map this data is at the face-block level. A shapefile of residential face-blocks is available to download at `housing_face_blocks/Archive.zip`. See how it was made in [`scripts/CreateHousingFaceBlocks.R`](scripts/CreateHousingFaceBlocks.R).

--------------------------------------------------------------------------------
**Here are a few examples of how this data can be visualized.**

See [`scripts/CreateHousesBuiltByYearDensityPlot.R`](https://github.com/jdjohn215/milwaukee-house-styles/blob/main/scripts/CreateHousesBuiltByYearDensityPlot.R) for the code.

![](/plots/BuiltByYear.svg)

See [`scripts/CreateHouseStyleYearBuiltBoxplot.R`](https://github.com/jdjohn215/milwaukee-house-styles/blob/main/scripts/CreateHouseStyleYearBuiltBoxplot.R) for the code.

![](/plots/HomesTypesByYear.svg)


See [`scripts/CreateHouseStyleMaps.R`](https://github.com/jdjohn215/milwaukee-house-styles/blob/main/scripts/CreateHouseStyleMaps.R) for the code.

These are some of Milwaukee's most common housing types. Each was dominant in their age, and they reflect contemporary modes of transportation. Old walking neighborhoods with modest cottages give way to a thick ring of duplexes whose working class occupants commuted on the new streetcars. The prosperity of the Roaring Twenties produced Milwaukee's narrow Bungalow Belt, and this pattern was repeated in turn with thousands of Cape Cod homes after World War II. As the 1950s progressed, Cape Cods gave way to newly popular Ranch homes.

<p align="middle">
  <img src="plots/Cottage_Type3_Map.png" width="19%" />
  <img src="plots/OldStyleDuplex_Type3_Map.png" width="19%" /> 
  <img src="plots/Bungalow_Type3_Map.png" width="19%" />
  <img src="plots/CapeCod_Type3_Map.png" width="19%" />
  <img src="plots/Ranch_Type3_Map.png" width="19%" />
</p>

Other styles are less associated with a single wave of building. Mansions, for instance, are limited to a handful of places in the City. Most notably, there is a large collection of mansions near Lake Park on the Upper East Side, but there are also pockets of these dwellings on the Near West Side and in Washington Heights. Similarly, Tudor-style homes are built in thick clusters in neighborhoods including Sherman Park and Story Hill. The "Colonial Style", as evidenced by the boxplot above, has been popular for the longest period of time. This enduring appeal is reflected in its scattered distribution around the city.


<p align="middle">
  <img src="plots/Mansion_Type3_Map.png" width="200" />
  <img src="plots/Tudor_Type3_Map.png" width="200" /> 
  <img src="plots/Colonial_Type3_Map.png" width="200" />
</p>


Detailed architectural style information isn't available for apartment or multi-unit condo buildings, but their pattern of construction is also revealing. Condo buildings are cocnentrated downtown, on the east side, and in a handful of large developments on the far northwest side. Apartment buildings are more widespread across the city. They make up large portions of the housing downtown and on the east side, as well as on the near west side. Across the rest of the city, they typically follow commercial corridors.


<p align="middle">
  <img src="plots/CondoMultiUnit_Type3_Map.png" width="200" />
  <img src="plots/ApartmentBuilding_Type3_Map.png" width="200" />
</p>
