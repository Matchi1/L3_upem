-- Q1
-- activation/désactivation du trigger

ALTER TABLE contient DISABLE TRIGGER verif_stock;
-- INSERT INTO contient VALUES (0, 4, 0, 0);
-- INSERT INTO contient VALUES (0, 196, 0, 0);
ALTER TABLE contient ENABLE TRIGGER verif_stock;
-- INSERT INTO contient VALUES (0, 4, 0, 0);

-- Q2
-- Le trigger s'enclenche quand une nouvelle ligne est rajouté dans la table contient
-- Elle sélectionne le magasin concerné et le nouveau produit concerné. 
-- Si le produit n'est pas déjà présent dans le magasin, il n'est pas ajouté
-- dans la table.

-- Cet élément sera ajouté dans la table
INSERT INTO contient VALUES (0, 51, 0, 0);
-- Cet élément ne sera pas ajouté dans la table
INSERT INTO contient VALUES (0, 4, 0, 0);

-- Q3 et Q4

-- On change la quantité du produit 184 dans le magasin 44
-- de 999 à 0 (la valeur n'est pas négative)
-- Le prix a été mis à jour également.
INSERT INTO contient VALUES (0, 184, 0, 1000);

