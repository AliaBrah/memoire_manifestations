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

SELECT e.nom , e.date , l.ville , COUNT(DISTINCT s."type") AS types_differents_sources
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
    e.pk_evenement , s."type" ;
