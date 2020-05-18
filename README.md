# OGC API - Features (ex: WFS3)
OGC API - Features test deployment on French Groundwater Information Network features

# First test
Serving Groundwater wells according to EPOS EU Research Infrastructure on Solid Earth logical model for Boreholes (https://github.com/opengeospatial/boreholeie/wiki/Relevant-Materials#epos-eu-research-infrastructure-on-solid-earth-conceptual-and-logical-model-)
- Map national data model to EPOS Borehole specification
- Serve it in OGC API - Features not loosing the semantics

OGC API - Features implementation deployed is Geoserver OGC API - Feature community module (https://github.com/geoserver/geoserver/tree/master/src/community/wfs3). First tests were using were using WFS 3.


# Achievements
- GML app-schema compliant automatic conversion to GeoJSON in GeoServer core
- GeoServer JSON-LD community plugin : https://docs.geoserver.org/stable/en/user/community/json-ld/index.html


# Challenges
- Current status of OGC API - Features (beginning of 2020) does not specify how semantics of data models is handled (as opposed to app-schema in WFS2)
- How to deal with features identifiers (we want URI on our features)
- No way in GeoServer for the user to define the expected structure of the GeoJSON (status May 2020)
