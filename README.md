# OGC API - Features (ex: WFS3)

OGC API - Features test deployment for the French Water Information System (ex on French Groundwater Information Network features and Surface features)

# Supporting Use Cases

## 1°/ GroundWater Wells - EPOS EU Research Infrastructure

Serving Groundwater wells according to EPOS EU Research Infrastructure on Solid Earth logical model for Boreholes (<https://github.com/opengeospatial/boreholeie/wiki/Relevant-Materials#epos-eu-research-infrastructure-on-solid-earth-conceptual-and-logical-model-)

- Map national data model to EPOS Borehole specification
- Serve it in OGC API - Features not loosing the semantics

OGC API - Features implementation deployed is Geoserver OGC API - Feature community module (<https://github.com/geoserver/geoserver/tree/master/src/community/wfs3>). First tests were using were using WFS 3 community module.

## 2°/ Surface and ground water Features - INSPIRE (API4INSPIRE project)

According to INSPIRE Hydro (HY), Environmental Monitoring Facilities (EF) with a link to observation download services (OGC SensorThings API).
Most of the work is described in this other repo <https://github.com/INSIDE-information-systems/API4INSPIRE>. See also <https://datacoveeu.github.io/API4INSPIRE/>

## 3°/ National information systems

Helpdesk for many French national information systems (ex : French Water Information System, under-ground, risks, ...).

# Achievements

Mainly through evolution funded by Pole INSIDE (INSIDE Research Center). By order of work.

- 1°/ GML app-schema compliant automatic conversion to GeoJSON in GeoServer core. Announcement: <http://blog.geoserver.org/2019/09/18/geoserver-2-16-released/>)
- 2°/ JSON-LD community plugin : <https://docs.geoserver.org/stable/en/user/community/json-ld/index.html>. Announcement: <http://blog.geoserver.org/2020/01/22/geoserver-2-16-2-released/> plugin that was then renamed into "GeoServer Features-Templating Extension"
- 3°/ GeoServer Features-Templating Extension (<https://docs.geoserver.org/stable/en/user/community/features-templating/index.html>). "Announcement" see State of [GeoServer 2.20 edition](https://docs.google.com/presentation/d/19Cmld0_VFePh1g4qUSfqNWWB0t-teClFpT3eUqpYGos/edit#slide=id.gf2908a2c17_0_231)
- 4°/ Geoserver SMART Data-loader extension (funded along with JRC during the API4INSPIRE project): <https://docs.geoserver.org/stable/en/user/community/smart-data-loader/index.html>
- 5°/ Support to the INSPIRE Good Practice: "INSPIRE download services based on OGC API - Features" : <https://github.com/INSPIRE-MIF/gp-ogc-api-features>


# Challenges

## Current challenges

- JSON Schemas and OGC API Features
- Queryables and OGC API Features
- Geoserver side : Foster reuse of the Features-Templating + SMART Data-Loader combo for a broader uptake of interoperability principles
- Information systems side : help in the mapping between historical models and internationnally agreed ones (ex : INSPIRE, OGC, ...)

## Initial challenges

- Status of OGC API - Features and implementations (beginning of 2020) do not specify how semantics of data models is handled; as opposed to app-schema in WFS2 (and especially within implementations like Geoserver and Deegree).
- How to deal with features identifiers (we want URI on our features)
- No way in GeoServer for the user to define the expected structure of the GeoJSON (status May 2020)
- Complexity for people to tame the servers so that they expose data with the internationnally agreed semantics (high entry ticket).
