-- on observe que les xmax sont à zéro, c-à-d qu'il n'y a pas eu de suppression
-- ctid indique à la fois le bloc et la ligne dans lequel les éléments ont été inséré

SELECT *, ctid, xmin, xmax FROM test;
