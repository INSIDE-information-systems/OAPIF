# WFS3
WFS3 test deployment on French Groundwater Information Network features

# First test
Serving Groundwater wells according to EPOS EU Research Infrastructure on Solid Earth logical model for Boreholes (https://github.com/opengeospatial/boreholeie/wiki/Relevant-Materials#epos-eu-research-infrastructure-on-solid-earth-conceptual-and-logical-model-)
- Map national data model to EPOS Borehole specification
- Serve it in WFS 3 not loosing the semantics

WFS 3 implementation deployed is Geoserver WFS 3 community module (https://github.com/geoserver/geoserver/tree/master/src/community/wfs3)

# Challenges
- Current status of WFS3 (beginning of 2019) does not specify how semantics of data models is handled (as opposed to app-schema in WFS2)
- How to deal with features identifiers (we want URI on our features)
