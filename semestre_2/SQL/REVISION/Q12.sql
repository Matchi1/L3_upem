SELECT soiree.idS, lieu, date
FROM soiree
INNER JOIN participe ON participe.idS = soiree.idS
GROUP BY soiree.ids
HAVING (count(surnom) * 100) / nbmax >= 90;
