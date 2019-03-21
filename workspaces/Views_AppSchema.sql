-- DROP MATERIALIZED VIEW app_diffussion_wfs3.ks_alias_mv;

CREATE MATERIALIZED VIEW app_diffussion_wfs3.ks_alias_mv
AS
 SELECT ali.indice,
    ali.ident_pour_organisme,
    ali.nom_organisme,
    ali.datmaj,
    dos.bss_id
   FROM app_diffussion_wfs3.bss_es_acces_autre_bd_mv ali
     LEFT JOIN app_diffussion_wfs3.bss_dossier_mv dos ON ali.indice::text = dos.indice::text;

--- changed!!!!!!!
-- Note: I've constrained this view by WHERE NOT ouv.libelle IS NULL AND NOT dep.profondeur_accessible IS NULL, in order to get semi-sane data!!! In reality, we need more values in the DB, then can remove
CREATE MATERIALIZED VIEW app_diffussion_wfs3.ks_borehole_mv
AS
 SELECT dos.indice,
    dos.bss_id,
    ouv.libelle,
    len.profondeur_investigation,
    ouv.z_ouvrage,
    stat.code_etat,
    ouv.prec_xy,
    locmes.code AS locmescode,
    locmes.libelle AS locmeslibelle,
    elmes.code AS elmescode,
    elmes.libelle AS elmeslibelle,
    dep.date_observation AS depth_date,
    dep.profondeur_accessible AS depth_val,
    dos.date_maj_dossier,
    pteau.code_statut_referentiel_point_eau,
    dos.date_creation,
    com.code_insee,
    com.nom_commune,
    com.num_commune,
    com.num_departement,
    ouv.latitude,
    ouv.longitude,
    st_pointfromtext(((('POINT('::text || ouv.latitude) || ' '::text) || ouv.longitude) || ')'::text, 4326) AS loc,
	null AS date_debut, --fac.date_debut,
    null AS date_fin, --fac.date_fin,
    null AS code_station --fac.code_station
   FROM app_diffussion_wfs3.bss_dossier_mv dos
     LEFT JOIN app_diffussion_wfs3.bss_ouvrage_mv ouv ON dos.indice::text = ouv.indice::text
     LEFT JOIN ( SELECT bss_profondeur_investigation.indice,
            bss_profondeur_investigation.date_observation,
            bss_profondeur_investigation.profondeur_investigation
           FROM app_diffussion_wfs3.bss_profondeur_investigation
          WHERE ((bss_profondeur_investigation.indice::text, bss_profondeur_investigation.date_observation) IN ( SELECT bss_profondeur_investigation_1.indice,
                    max(bss_profondeur_investigation_1.date_observation) AS max
                   FROM app_diffussion_wfs3.bss_profondeur_investigation bss_profondeur_investigation_1
                  GROUP BY bss_profondeur_investigation_1.indice))) len ON dos.indice::text = len.indice::text
     LEFT JOIN ( SELECT DISTINCT ON (bss_ouvrage_etat_physique.indice) bss_ouvrage_etat_physique.indice,
            bss_ouvrage_etat_physique.code_etat,
            bss_ouvrage_etat_physique.date_debut,
            bss_ouvrage_etat_physique.date_fin
           FROM app_diffussion_wfs3.bss_ouvrage_etat_physique
          WHERE bss_ouvrage_etat_physique.date_fin IS NULL
          ORDER BY bss_ouvrage_etat_physique.indice, bss_ouvrage_etat_physique.date_debut DESC) stat ON dos.indice::text = stat.indice::text
     LEFT JOIN app_diffussion_wfs3.referentiel_interne_lex_mode_obtention_xy_mv locmes ON ouv.code_mode_obtention_xy = locmes.code
     LEFT JOIN app_diffussion_wfs3.referentiel_interne_lex_mode_obtention_z_mv elmes ON ouv.code_mode_obtention_z = elmes.code
     LEFT JOIN app_diffussion_wfs3.bss_profondeur_accessible dep ON dos.indice::text = dep.indice::text
     LEFT JOIN app_diffussion_wfs3.bsseau_point_eau pteau ON dos.indice::text = pteau.indice::text
     LEFT JOIN app_diffussion_wfs3.referentiel_interne_lex_communes com ON dos.num_commune::text = com.num_commune::text AND dos.num_departement::text = com.num_departement::text
     -- LEFT JOIN app_diffussion_wfs3.bsseau_pe_sh fac ON dos.indice::text = fac.indice::text
  --WHERE NOT ouv.libelle IS NULL AND NOT dep.profondeur_accessible IS NULL
 LIMIT 1000;
 
		
CREATE MATERIALIZED VIEW app_diffussion_wfs3.ks_borehole_use_mv
AS
 SELECT ou.date_debut,
    ou.date_fin,
    dos.bss_id,
    dos.indice,
    fon.code_sandre
   FROM app_diffussion_wfs3.bss_dossier dos
     JOIN app_diffussion_wfs3.bss_ouvrage ouv ON ouv.indice::text = dos.indice::text
     JOIN app_diffussion_wfs3.bss_ouvrage_fonction ou ON ou.indice::text = dos.indice::text
     JOIN app_diffussion_wfs3.referentiel_interne_lex_fonction_ouvrage fon ON ou.code_fonction = fon.code
  ORDER BY ouv.indice;
	

CREATE MATERIALIZED VIEW app_diffussion_wfs3.ks_georesource_mv
AS
 WITH geo AS (
         SELECT bsseau_pe_hg_bdlisa_histo.id,
            bsseau_pe_hg_bdlisa_histo.indice,
            bsseau_pe_hg_bdlisa_histo.code_entite_ref,
            bsseau_pe_hg_bdlisa_histo.code_entite,
            bsseau_pe_hg_bdlisa_histo.date_debut,
            bsseau_pe_hg_bdlisa_histo.date_fin,
            bsseau_pe_hg_bdlisa_histo.code_qualite_association,
            bsseau_pe_hg_bdlisa_histo.commentaire,
            bsseau_pe_hg_bdlisa_histo.prof_toit,
            bsseau_pe_hg_bdlisa_histo.prof_mur,
            bsseau_pe_hg_bdlisa_histo.entite_captee
           FROM app_diffussion_wfs3.bsseau_pe_hg_bdlisa_histo
          WHERE bsseau_pe_hg_bdlisa_histo.date_fin IS NULL AND bsseau_pe_hg_bdlisa_histo.code_entite_ref = (( SELECT max(l.code) AS max
                   FROM app_diffussion_wfs3.referentiel_interne_lex_hg_bdlisa_ref l))
        )
 SELECT geo.indice,
    geo.id,
    geo.commentaire,
    geo.date_debut,
    geo.date_fin,
    geo.prof_mur,
    geo.prof_toit,
    geo.entite_captee,
    geo.code_entite,
    nam.nom_entite,
    meta.code_sandre AS met_code,
    qua.code_sandre AS qua_code
   FROM geo
     LEFT JOIN app_diffussion_wfs3.bsseau_pe_hg_bdlisa_methode met ON geo.id = met.id_pe_hg_bdlisa
     LEFT JOIN app_diffussion_wfs3.referentiel_interne_lex_methode_association_mv meta ON met.code_methode_association = meta.code
     LEFT JOIN app_diffussion_wfs3.referentiel_interne_lex_qualite_association qua ON geo.code_qualite_association = qua.code
	 LEFT JOIN app_diffussion_wfs3.referentiel_externe_ln_entite_hydrogeol_bdlisa nam ON geo.code_entite::text = nam.code_entite::text AND geo.code_entite_ref = nam.code_entite_ref;
		
CREATE MATERIALIZED VIEW app_diffussion_wfs3.ks_parameter_mv
AS
 SELECT pteau.indice,
    'http://xml.sandre.eaufrance.fr/pte/3/sandre_fmt_xml_pte.xsd#sa_pte:PTE/sa_pte:estUneSource/sa_pte:TypSource'::text AS namestr,
        CASE
            WHEN pteau.code_type_source IS NULL THEN 'http://id.eaufrance.fr/nsa/918#XXXXX'::text
            ELSE concat('http://id.eaufrance.fr/nsa/918#', pteau.code_type_source)
        END AS valuestr
   FROM app_diffussion_wfs3.bss_dossier_mv dos
     JOIN app_diffussion_wfs3.bsseau_point_eau pteau ON dos.indice::text = pteau.indice::text
  WHERE NOT pteau.indice IS NULL AND NOT pteau.code_type_source IS NULL
UNION
 SELECT pteau.indice,
    'http://xml.sandre.eaufrance.fr/pte/3/sandre_fmt_xml_pte.xsd#sa_pte:PTE/sa_pte:estUneSource/sa_pte:RegimeSource'::text AS namestr,
        CASE
            WHEN pteau.code_regime_source IS NULL THEN 'http://id.eaufrance.fr/nsa/918#XXXXX'::text
            ELSE concat('http://id.eaufrance.fr/nsa/919#', pteau.code_regime_source)
        END AS valuestr
   FROM app_diffussion_wfs3.bss_dossier_mv dos
     JOIN app_diffussion_wfs3.bsseau_point_eau pteau ON dos.indice::text = pteau.indice::text
  WHERE NOT pteau.indice IS NULL AND NOT pteau.code_regime_source IS NULL
UNION
 SELECT pteau.indice,
    'http://xml.sandre.eaufrance.fr/pte/3/sandre_fmt_xml_pte.xsd#sa_pte:PTE/sa_pte:estUneSource/sa_pte:SourceAmenagee'::text AS namestr,
        CASE
            WHEN pteau.source_amenagee IS NULL THEN 'http://id.eaufrance.fr/nsa/918#XXXXX'::text
            ELSE concat('http://id.eaufrance.fr/nsa/919#', pteau.source_amenagee)
        END AS valuestr
   FROM app_diffussion_wfs3.bss_dossier_mv dos
     JOIN app_diffussion_wfs3.bsseau_point_eau pteau ON dos.indice::text = pteau.indice::text
  WHERE NOT pteau.indice IS NULL AND NOT pteau.source_amenagee IS NULL
UNION
 SELECT dos.indice,
    'http://xml.sandre.eaufrance.fr/pte/3/sandre_fmt_xml_pte.xsd#sa_pte:PTE/sa_pte:estDEtat/sa_pte:DateEtatPTE'::text AS namestr,
    eph.date_debut::text AS valuestr
   FROM app_diffussion_wfs3.bss_dossier dos
     LEFT JOIN app_diffussion_wfs3.bss_ouvrage_etat_physique eph ON dos.indice::text = eph.indice::text
  WHERE NOT eph.indice IS NULL AND NOT eph.date_debut IS NULL;
		
CREATE MATERIALIZED VIEW app_diffussion_wfs3.ks_pe_sh_mv
TABLESPACE pg_default
AS SELECT dos.indice,
    fac.date_debut,
    fac.date_fin,
    fac.code_station,
        CASE
            WHEN fac.date_fin IS NULL THEN 'unknown'::text
            ELSE NULL::text
        END AS date_fin_unknown
   FROM app_diffussion_wfs3.bss_dossier_mv dos
     JOIN app_diffussion_wfs3.bsseau_pe_sh fac ON dos.indice::text = fac.indice::text
;
														
