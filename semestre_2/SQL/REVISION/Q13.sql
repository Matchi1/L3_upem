SELECT personne.surnom, nom, prenom, SUM(entree) AS nbentree
FROM personne
NATURAL JOIN participe
INNER JOIN soiree ON soiree.ids = participe.ids
GROUP BY personne.surnom
ORDER BY nbentree DESC;
