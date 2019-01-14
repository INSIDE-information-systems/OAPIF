CREATE MATERIALIZED VIEW app_diffussion_wfs3.bss_dossier_mv
AS
 SELECT dossier.indice,
    dossier.code_nature,
    dossier.raison_suppression,
    dossier.bss_id,
    dossier.num_commune, -- added
    dossier.num_departement, -- added
    dossier.date_creation,
    dossier.date_maj_dossier
   FROM bss.dossier;

CREATE MATERIALIZED VIEW app_diffussion_wfs3.bss_es_acces_autre_bd_mv
AS
 SELECT es_acces_autre_bd.indice,
    es_acces_autre_bd.nom_organisme,
    es_acces_autre_bd.ident_pour_organisme,
    es_acces_autre_bd.nom_pour_organisme,
    es_acces_autre_bd.datmaj -- added
   FROM bss.es_acces_autre_bd;


CREATE MATERIALIZED VIEW app_diffussion_wfs3.bss_ouvrage_mv
AS
 SELECT ouvrage.indice,
    ouvrage.designation,
    ouvrage.libelle,
    ouvrage.x_saisie,
    ouvrage.y_saisie,
    ouvrage.s_saisie,
    ouvrage.code_mode_obtention_xy,
    ouvrage.code_mode_obtention_z,
    ouvrage.z_ouvrage,
    ouvrage.prec_xy, -- added
    ouvrage.longitude,
    ouvrage.latitude,
    ouvrage.commentaire_position
   FROM bss.ouvrage;




-- missing in views
CREATE MATERIALIZED VIEW app_diffussion_wfs3.referentiel_interne_lex_methode_association_mv
AS
 SELECT lex_methode_association.code,
    lex_methode_association.code_sandre
   FROM referentiel_interne.lex_methode_association;

CREATE MATERIALIZED VIEW app_diffussion_wfs3.referentiel_interne_lex_mode_obtention_xy_mv AS
 SELECT lex_mode_obtention_xy.code,
    lex_mode_obtention_xy.libelle, -- added
    lex_mode_obtention_xy.code_sandre
   FROM referentiel_interne.lex_mode_obtention_xy	 
	 
CREATE MATERIALIZED VIEW app_diffussion_wfs3.referentiel_interne_lex_mode_obtention_z_mv AS
 SELECT lex_mode_obtention_z.code,
 	lex_mode_obtention_z.libelle, -- added
    lex_mode_obtention_z.code_sandre
   FROM referentiel_interne.lex_mode_obtention_z;



