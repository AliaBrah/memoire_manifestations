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