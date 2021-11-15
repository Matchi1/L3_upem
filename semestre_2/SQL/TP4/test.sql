DROP TABLE IF EXISTS test CASCADE;

CREATE TABLE test(
	id serial primary key,
	a int,
	b int
);

INSERT INTO test (a, b) VALUES (1, 1);
INSERT INTO test (a, b) VALUES (2, 2);
