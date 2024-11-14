SELECT ma.nom, e.nom 
FROM moyen_action ma 
JOIN liaison_moyen_evenement lme 
ON ma.pk_moyen_action = lme.fk_moyen_action 
JOIN evenement e 
ON lme.fk_evenement = e.pk_evenement;

SELECT p.prenom , p.nom 
FROM personne p 
JOIN participation p2
ON p2.fk_personne = p.pk_personne 
JOIN evenement e 
ON p2.fk_evenement = e.pk_evenement 
JOIN membre m 
ON m.fk_personne = p.pk_personne 
JOIN organisation_association oa 
ON m.fk_organisation = oa.pk_organisation 
WHERE m.pk_membre = 1 AND p2.pk_participation = 1;


SELECT e.nom ,l.ville , s."type" 
FROM "source" s 
JOIN liaision_source_evenement lse 
ON s.pk_source = lse.fk_source 
JOIN evenement e 
ON e.pk_evenement = lse.fk_evenement
JOIN lieu l 
ON l.pk_lieu = e.fk_lieu_debut ;

SELECT e.pk_evenement, e.nom , e.date , l.ville , COUNT(DISTINCT s."type") AS types_differents_sources
FROM "source" s 
JOIN liaision_source_evenement lse 
ON s.pk_source = lse.fk_source 
JOIN evenement e 
ON e.pk_evenement = lse.fk_evenement
JOIN lieu l 
ON l.pk_lieu = e.fk_lieu_debut
GROUP BY e.pk_evenement ;

SELECT
    e.nom AS evenement,
    e.date ,
    l.ville,
    s."type",
    COUNT(s.pk_source) AS nombre_objets_lies
FROM "source" s 
JOIN liaision_source_evenement lse 
ON s.pk_source = lse.fk_source 
JOIN evenement e 
ON e.pk_evenement = lse.fk_evenement
JOIN lieu l 
ON l.pk_lieu = e.fk_lieu_debut
GROUP BY
    e.pk_evenement , s."type" 
ORDER BY
    e.date, e.pk_evenement , s."type";

SELECT DISTINCT e.pk_evenement , e.nom , e.date, l.pays, l.ville
FROM evenement e
JOIN liaison_moyen_evenement lme 
ON e.pk_evenement = lme.fk_evenement 
JOIN moyen_action ma 
ON ma.pk_moyen_action = lme.fk_moyen_action 
JOIN lieu l
ON l.pk_lieu = e.fk_lieu_debut
WHERE ma."type" LIKE '%violent%'
ORDER BY e.date ;

SELECT DISTINCT e.pk_evenement, e.nom, e.date, e."type", l.ville, oa.nom 
FROM evenement e 
JOIN liaison_pres_organisation_evenement lpoe 
ON lpoe.fk_evenement = e.pk_evenement 
JOIN organisation_association oa 
ON oa.pk_organisation = lpoe.fk_organisation
JOIN lieu l 
ON l.pk_lieu = e.fk_lieu_debut 
WHERE oa.nom LIKE '%Ligue%'
ORDER BY e.date;

SELECT DISTINCT e.pk_evenement , e.nom , e.date, e."type", l.ville 
FROM personne p 
JOIN participation p2 
ON p.pk_personne = p2.fk_personne 
JOIN evenement e 
ON e.pk_evenement = p2.fk_evenement 
JOIN lieu l 
ON l.pk_lieu = e.fk_lieu_debut 
WHERE p2.fk_personne = '1';

SELECT 
    e.pk_evenement AS id_objet,
    e.nom AS nom_objet,
    COUNT(oa.pk_organisation) AS nombre_liaisons
FROM organisation_association oa 
JOIN liaison_pres_organisation_evenement lpoe
ON lpoe.fk_organisation = oa.pk_organisation 
JOIN evenement e 
ON e.pk_evenement = lpoe.fk_evenement
JOIN lieu l 
 ORDER BY e.date;

-- view pour analyse de réseaux

-- CREATE VIEW resaux_asso_evenement
-- AS
SELECT 
    oa.nom ,
    e.pk_evenement, 
    e.nom AS nom_evenement, 
    e.date, 
    l.nom AS nom_lieu, 
    l.ville, 
    l.pays
FROM 
    organisation_association oa 
JOIN 
    liaison_pres_organisation_evenement lpoe ON lpoe.fk_organisation = oa.pk_organisation 
JOIN 
    evenement e ON e.pk_evenement = lpoe.fk_evenement
JOIN 
    lieu l ON l.pk_lieu = e.fk_lieu_debut
GROUP BY 
    oa.nom, 
    e.nom, 
    e.date, 
    l.nom, 
    l.ville, 
    l.pays
ORDER BY 
    e.date;
 
 SELECT pk_evenement, COUNT(*) AS eff , date 
 FROM resaux_asso_evenement rae
GROUP by pk_evenement 
ORDER BY date ;

SELECT e.pk_evenement, e.nom, e.date, l.nom ,l.ville, l.pays, l.latitude , l.longitude 
FROM evenement e 
JOIN lieu l 
ON e.fk_lieu_debut = l.pk_lieu ;

-- Analyse bivariée

SELECT 
    e."type" AS nom_evenement,
    oa.nom AS nom_organisation,
    COUNT(lpoe.fk_organisation) AS occurrences
FROM 
    evenement e 
JOIN 
    liaison_pres_organisation_evenement lpoe ON e.pk_evenement = lpoe.fk_evenement 
JOIN 
    organisation_association oa ON lpoe.fk_organisation = oa.pk_organisation 
GROUP BY 
    e.type, oa.nom 
ORDER BY 
    occurrences DESC;

SELECT 
    e."type" AS nom_evenement,
    oa.nom AS nom_organisation,
    COUNT(DISTINCT lpoe.fk_organisation) AS occurrences,  -- Compte les organisations
    GROUP_CONCAT(DISTINCT e.date) AS dates_associees
FROM 
    evenement e 
JOIN 
    liaison_pres_organisation_evenement lpoe ON e.pk_evenement = lpoe.fk_evenement 
JOIN 
    liaison_org_organisation_evenement looe ON looe.fk_evenement = e.pk_evenement
JOIN 
    organisation_association oa ON oa.pk_organisation = lpoe.fk_organisation 
GROUP BY 
    e.type, oa.nom 
ORDER BY 
    occurrences DESC;
   






  SELECT 
    e.nom AS nom_evenement,
    oa.nom AS nom_organisation,
    COUNT(lpoe.fk_organisation) AS occurrences
FROM 
    evenement e 
JOIN 
    liaison_pres_organisation_evenement lpoe ON e.pk_evenement = lpoe.fk_evenement 
JOIN 
    organisation_association oa ON lpoe.fk_organisation = oa.pk_organisation 
GROUP BY 
    e.nom, oa.nom 
ORDER BY 
    occurrences DESC;

-- Script moyens d'actions et évolutions dans le cycle.
SELECT 
    ma.nom ,
    e.pk_evenement, 
    e.nom AS nom_evenement, 
    e.date, 
    l.nom AS nom_lieu, 
    l.ville, 
    l.pays
FROM 
    moyen_action ma 
JOIN 
   liaison_moyen_evenement lme ON lme.fk_moyen_action = ma.pk_moyen_action 
JOIN 
    evenement e ON e.pk_evenement = lme.fk_evenement
JOIN 
    lieu l ON l.pk_lieu = e.fk_lieu_debut
GROUP BY 
    ma.nom, 
    e.nom, 
    e.date, 
    l.nom, 
    l.ville, 
    l.pays
ORDER BY 
    e.date;