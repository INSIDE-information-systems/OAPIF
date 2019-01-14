app-schema configuration files go here

Currently, we have the following files:
* MappingEPOS_DC.xml - App Schema Mapping file for eposb:Borehole
* Views_DB.sql - Fixes for various views from app_diffussion_wfs3, either adding missing columns required for mapping, or missing views not yet defined. All implemented as materialized views to keep separate from BRGM work. Should eventually not be required when the views in app_diffussion_wfs3 have been adjusted as required.
* Views_AppSchema.sql - DB Views required for App Schema Mapping. Contains the following views corresponding the the listed FeatureTypes and DataTypes:

** ks_borehole_mv: Main view for Borehole FT. Contains columns for all base level elements, as well as for nested types with a cardinality of 1
** ks_alias_mv: View for eposb:alias content
** ks_borehole_use_mv: View for eposb:BoreholeUse and eposb:Purpose content (same content according to mapping)
** ks_georesource_mv: View for eposb:BoreholeGeoresource content
** ks_parameter_mv: View for om:NamedValue (om:parameter) content. Note that while in all other cases, URI prefixes are concatenated within the App Schema Mapping, for the parameter, it makes for more compact mapping to provide the full content of the name and value within the view

In addition, the following workspaces must be configured within GeoServer:
* eposb: base workspace, contains App Schema Mapping
* gco
* gmd
* gml
* gwml-wellconstruction
* om
* sam
* sams
* xlink
* xsi
