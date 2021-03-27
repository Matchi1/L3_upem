CREATE OR REPLACE FUNCTION majStock()
RETURNS TRIGGER AS
$$
	DECLARE
		mag int; sto stocke%ROWTYPE;

	BEGIN
		SELECT idmag INTO mag FROM facture WHERE idfac = NEW.idfac;

		RAISE NOTICE 'Le magasin concerné est le magasin %', mag;

		SELECT * INTO sto FROM stocke WHERE idmag = mag AND idpro = NEW.idpro;
		IF NOT FOUND THEN
			RAISE NOTICE 'Le magasin % ne vend pas le produit %.', mag, NEW.idpro;
			RETURN NULL;
		END IF;		

		IF (sto.quantite < NEW.quantite) THEN 
			NEW.quantite = sto.quantite;
		END IF;

		UPDATE stocke SET quantite = (sto.quantite - NEW.quantite) WHERE idmag = mag and idpro = NEW.idpro;
		
		NEW.prixunit = sto.prixunit;
		RETURN NEW ;
	END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER verif_stock
BEFORE INSERT ON contient
FOR EACH ROW
EXECUTE PROCEDURE majStock();
