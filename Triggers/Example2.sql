/*  EX.2  */
/* step 1 -- Create Table*/
CREATE TABLE EMPLOYEES_LOG
(
    log_date DATE,
    action VARCHAR2(50),
    BY_USER VARCHAR2(50)
);

/* step 2 -- Create Triggers*/

/

/*step 3 -- INSERT*/
INSERT INTO employees VALUES (employees_seq.nextval,'Aman','Pooja','123@gmail0com','0001112222',sysdate,'AD_PRES','20','','100','30');