# milwaukee-house-styles

Like a tree, Milwaukee's residential neighborhoods spread in concentric rings around the downtown commercial core. Each layer preserves a distinctive swathe of homes, bearing witness to the way a generation of Milwaukeens lived and worked, all while likewise shaping the way every subsequent generation experiences their city.

--------------------------------------------------------------------------------

The Milwaukee Assessor's Office maintains an extensive database of property records. They assign one of a list of architectural styles to each house in Milwaukee. This repo shows ways of using this data.

The core parcel-level data is in `data/ResidentialParcels_2021.csv`. [Documentation here](https://github.com/jdjohn215/milwaukee-house-styles/blob/main/data/ResidentialParcels_2021_ABOUT.md).

Read the City Assessor's [definitions of each home style here](https://github.com/jdjohn215/milwaukee-house-styles/blob/main/data/HomeStylesDocumentation.md).

One good way to map this data is at the face-block level. A shapefile of residential face-blocks is available to download at [`residential_face_blocks/Archive.zip`](https://github.com/jdjohn215/milwaukee-house-styles/raw/main/residential_face_blocks/Archive.zip). See how it was made in [`scripts/CreateResidentialFaceBlocks.R`](https://github.com/jdjohn215/milwaukee-house-styles/blob/main/scripts/CreateResidentialFaceBlocks.R).

--------------------------------------------------------------------------------
**Here are a few examples of how this data can be visualized.**

See [`scripts/CreateHousesBuiltByYearDensityPlot.R`](https://github.com/jdjohn215/milwaukee-house-styles/blob/main/scripts/CreateHousesBuiltByYearDensityPlot.R) for the code.

![](/plots/BuiltByYear.svg)

See [`scripts/CreateHouseStyleYearBuiltBoxplot.R`](https://github.com/jdjohn215/milwaukee-house-styles/blob/main/scripts/CreateHouseStyleYearBuiltBoxplot.R) for the code.

![](/plots/HomesTypesByYear.svg)


See [`scripts/CreateHouseStyleMaps.R`](https://github.com/jdjohn215/milwaukee-house-styles/blob/main/scripts/CreateHouseStyleMaps.R) for the code.

These are some of Milwaukee's most common housing types. Each was dominant in their age, and they reflect contemporary modes of transportation. Old walking neighborhoods with modest cottages give way to a thick ring of duplexes whose working class occupants commuted on the new streetcars. The prosperity of the Roaring Twenties produced Milwaukee's narrow Bungalow Belt, and this pattern was repeated in turn with thousands of Cape Cod homes after World War II. As the 1950s progressed, Cape Cods gave way to newly popular Ranch homes.

<img src="plots/Cottage_SuperType_Map.png" alt="drawing" width="200"/>
<img src="plots/OldStyleDuplex_SuperType_Map.png" alt="drawing" width="200"/>
<img src="plots/Bungalow_SuperType_Map.png" alt="drawing" width="200"/>
<img src="plots/CapeCod_SuperType_Map.png" alt="drawing" width="200"/>
<img src="plots/Ranch_SuperType_Map.png" alt="drawing" width="200"/>

Other styles are less associated with a single wave of building. Mansions, for instance, are limited to a handful of places in the City. Most notably, there is a large collection of mansions near Lake Park on the Upper East Side, but there are also pockets of these dwellings on the Near West Side and in Washington Heights. Similarly, Tudor-style homes are built in thick clusters in neighborhoods including Sherman Park and Story Hill. The "Colonial Style", as evidenced by the boxplot above, has been popular for the longest period of time. This enduring appeal is reflected in its scattered distribution around the city.

<img src="plots/Mansion_SuperType_Map.png" alt="drawing" width="200"/>
<img src="plots/Tudor_SuperType_Map.png" alt="drawing" width="200"/>
<img src="plots/Colonial_SuperType_Map.png" alt="drawing" width="200"/>
