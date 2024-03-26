-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "ALTER EXTENSION vector UPDATE TO '0.7.0'" to load this file. \quit

CREATE OPERATOR <|> (
	LEFTARG = vector, RIGHTARG = vector, PROCEDURE = l1_distance,
	COMMUTATOR = '<|>'
);

CREATE OPERATOR CLASS vector_l1_ops
	FOR TYPE vector USING ivfflat AS
	OPERATOR 1 <|> (vector, vector) FOR ORDER BY float_ops,
	FUNCTION 1 l1_distance(vector, vector),
	FUNCTION 3 l1_distance(vector, vector);

CREATE OPERATOR CLASS vector_l1_ops
	FOR TYPE vector USING hnsw AS
	OPERATOR 1 <|> (vector, vector) FOR ORDER BY float_ops,
	FUNCTION 1 l1_distance(vector, vector);
