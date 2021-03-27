-- Q1
DROP TABLE IF EXISTS historiquePrix CASCADE;

CREATE TABLE historiquePrix (
	log_id serial primary key,
	date date,
	idmag int references magasin(idmag),
	idpro int references produit(idpro),
	ancienPrix numeric(5,2),
	nouveauPrix numeric(5,2)
);

--Q2
CREATE OR REPLACE FUNCTION majPrix()
RETURNS TRIGGER AS
$$
	DECLARE
		minprix float; mag magasin%ROWTYPE; pro produit%ROWTYPE;

	BEGIN
		SELECT min(prixunit) INTO minprix FROM stocke WHERE idpro = OLD.idpro and idmag != OLD.idmag;
		SELECT * INTO mag FROM magasin WHERE OLD.idmag = idmag;
		SELECT * INTO pro FROM produit WHERE OLD.idpro = idpro;
		INSERT INTO historiquePrix(date, idmag, idpro, ancienPrix, nouveauPrix)
		VALUES (now(), OLD.idmag, OLD.idpro, OLD.prixunit, NEW.prixunit);
		
		-- déterminer si le nouveau prix est devenu le meilleur prix du marché
		IF (minprix > NEW.prixunit) THEN
			RAISE NOTICE 'le nouveaux prix est % (anciennement %).
			nom du magasin: %, lieu du magasin: %, ref du produit: %, libelle: %, quantité: %', 
			NEW.prixunit, minprix, mag.nom, mag.ville, pro.idpro, pro.libelle, OLD.quantite;
		END IF;

		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS verif_prix ON stocke;

CREATE TRIGGER verif_prix
AFTER UPDATE ON stocke
FOR EACH ROW
WHEN (OLD.prixunit != NEW.prixunit)
EXECUTE PROCEDURE majPrix();

-- Vide
SELECT * FROM historiqueprix;
-- Met à jour le prix des produits avec l'id égale à 44.
UPDATE stocke SET prixunit = 0 WHERE idpro = 44 and idmag = 6;
SELECT * FROM historiqueprix;

