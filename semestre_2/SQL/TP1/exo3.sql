--Q1
CREATE OR REPLACE FUNCTION majFidelite()
RETURNS TRIGGER AS
$$
	DECLARE
		new_point int; add_point int; fid fidelite%ROWTYPE; pro produit%ROWTYPE;
		fac facture%ROWTYPE; pro_ajoute contient%ROWTYPE;

	BEGIN
		SELECT * INTO fac FROM facture WHERE NEW.idfac = idfac;
		SELECT * INTO fid FROM fidelite WHERE numcli = fac.numcli and idmag = fac.idmag;
		SELECT * INTO pro_ajoute FROM contient WHERE NEW.idfac = idfac and NEW.idpro = idpro;
		add_point = pro_ajoute.quantite * pro_ajoute.prixunit;
		IF (fid IS NULL) THEN
			RAISE NOTICE 'Ce client ne possède pas de carte de fidélité
			il aurait pu gagner % de point de fidélité', add_point;
			RETURN NULL;
		END IF;
		
		UPDATE fidelite SET points = points + add_point WHERE fac.numcli = numcli and fac.idmag = idmag;
		RAISE NOTICE 'Le client % chez le magasin % va recevoir des points (nombre de points ajoutés: %)', 
		fac.numcli, fac.idmag, add_point;
			
		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS verif_fidel ON contient;

CREATE TRIGGER verif_fidel
AFTER INSERT ON contient
FOR EACH ROW
EXECUTE PROCEDURE majFidelite();

-- Q2
CREATE OR REPLACE FUNCTION plafond()
RETURNS TRIGGER AS
$$
	DECLARE

	BEGIN
		IF (NEW.points > 1000) THEN
			NEW.points = 1000;
		END IF;
		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS majPlafond ON fidelite;

CREATE TRIGGER majPlafond
BEFORE UPDATE ON fidelite
FOR EACH ROW
EXECUTE PROCEDURE plafond();

INSERT INTO contient VALUES (0, 193, 5.23, 20);
-- vérification de l'actualisation du prix à l'unité
SELECT * FROM contient WHERE idfac = 0 and idpro = 193;
-- vérification de l'ajout des points de fidélité
SELECT * FROM fidelite WHERE numcarte = 0;
INSERT INTO contient VALUES (8, 192, 5.23, 20);
SELECT * FROM fidelite WHERE numcarte = 0;

UPDATE fidelite SET points = 10000 WHERE numcarte = 0;
-- vérification du plafonnement de la carte de fidélité
SELECT * FROM fidelite WHERE numcarte = 0;
