SELECT deguisement.avatar, nommag
FROM vendre
INNER JOIN deguisement ON deguisement.modele = vendre.modele,
	(
		SELECT avatar, min(prix) AS minprix
		FROM vendre 
		INNER JOIN deguisement ON vendre.modele = deguisement.modele
		GROUP BY avatar
	) AS tabmin
WHERE deguisement.avatar = tabmin.avatar 
and vendre.prix = tabmin.minprix;

