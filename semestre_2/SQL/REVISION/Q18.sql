SELECT soiree.ids
FROM soiree
INNER JOIN participe ON participe.ids = soiree.ids
GROUP BY soiree.ids
HAVING COUNT(surnom) >= 70;
