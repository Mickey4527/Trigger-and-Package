/* step 1 -- Create Triggers*/

DECLARE
    
BEGIN
   
   dbms_output.put_line('Old salary: ' || :old.salary);
   dbms_output.put_line('New salary: ' || :new.salary);
   dbms_output.put_line('Salary difference: ' || sal_diff);
END;
/*step 2*/
SET SERVEROUTPUT ON;

/
/*step 3 -- INSERT*/
INSERT INTO employees VALUES (employees_seq.nextval,'Aman','Pooja','123@gmail0com','0001112222',sysdate,'AD_PRES','20','','100','30');

/*step 4 -- UPDATE*/


/*step 5 -- DELETE*/

