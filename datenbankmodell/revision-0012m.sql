DROP TABLE doppik.abfallbehaelter CASCADE;

CREATE TABLE doppik.abfallbehaelter
(
	ident character(6) NOT NULL,
	CONSTRAINT pk_abfallbehaelter_id PRIMARY KEY (id)
)
INHERITS(okstra.strassenausstattung_punkt);

CREATE TRIGGER tr_idents_add_ident BEFORE INSERT ON doppik.abfallbehaelter FOR EACH ROW EXECUTE PROCEDURE base.idents_add_ident();

CREATE TRIGGER tr_idents_remove_ident AFTER DELETE ON doppik.abfallbehaelter FOR EACH ROW EXECUTE PROCEDURE base.idents_remove_ident();
