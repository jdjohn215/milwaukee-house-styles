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

![Cottages](plots/Cottage_SuperType_Map.png) <!-- .element height="50%" width="50%" -->
