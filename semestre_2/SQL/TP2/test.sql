DROP TABLE IF EXISTS test CASCADE;

CREATE TABLE test(
	id serial primary key,
	a int,
	b int
);

CREATE OR REPLACE FUNCTION pair()
RETURNS TRIGGER AS
$$
	BEGIN
		IF (NEW.a % 2 = 0) THEN
			RAISE NOTICE 'a est pair';
		END IF;
		IF (NEW.b % 2 = 0) THEN
			RETURN NULL;
		END IF;
		IF (NEW.a = NEW.b) THEN
			RAISE EXCEPTION 'a égale à b';
		END IF;
		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS verif_prix ON stocke;

CREATE TRIGGER pair
BEFORE INSERT ON test
FOR EACH ROW
EXECUTE PROCEDURE pair();

BEGIN;
INSERT INTO test(a, b) VALUES (1, 1), (2, 3), (5, 4);
COMMIT;
