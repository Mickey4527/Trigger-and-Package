/*  EX.3  */
/*step 1*/
CREATE TABLE COMMENTS(
    COMMENTS_TITLE VARCHAR2(256)
);

/*step 2*/
INSERT INTO COMMENTS VALUES ('Trabadsat');

/*step 3*/
CREATE OR REPLACE TRIGGER TRG_CONVERT_WORDS
BEFORE INSERT OR UPDATE ON COMMENTS
FOR EACH ROW
BEGIN
    
END;
/
/*step 4*/
INSERT INTO COMMENTS VALUES('TrABaDsATY');
INSERT INTO COMMENTS VALUES('Nai kor Som Lon');
INSERT INTO COMMENTS VALUES('Nai kor Pita');