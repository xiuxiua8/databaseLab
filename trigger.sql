CREATE TABLE BK126 (
   Sno VARCHAR(10),
   Cno VARCHAR(10),
   GRADE DECIMAL(5,2),
   DDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION backup_deleted_sc()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO BK126 (Sno, Cno, GRADE, DDATE)
    VALUES (OLD.Sno, OLD.Cno, OLD.GRADE, CURRENT_TIMESTAMP);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_backup_on_delete
    BEFORE DELETE ON SC126
    FOR EACH ROW
EXECUTE PROCEDURE backup_deleted_sc();


DO
$$
    DECLARE
        rec RECORD;
        counter INT := 0;
    BEGIN
        FOR rec IN
            SELECT Sno, Cno FROM SC126 WHERE GRADE <= 60 LIMIT 100
            LOOP
                DELETE FROM SC126 WHERE Sno = rec.Sno AND Cno = rec.Cno;
                counter := counter + 1;
            END LOOP;
        RAISE NOTICE 'Deleted % rows with NULL GRADE', counter;
    END;
$$;


SELECT * FROM BK126 LIMIT 10;
