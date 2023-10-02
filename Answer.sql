/*  EX.1  */
/* step 1 -- Create Triggers*/
CREATE OR REPLACE TRIGGER display_salary_changes
BEFORE INSERT OR UPDATE OR DELETE ON employees
FOR EACH ROW
WHEN (new.employee_id > 0)
DECLARE
    sal_diff number;
BEGIN
   sal_diff := :new.salary - :old.salary;
   dbms_output.put_line('Old salary: ' || :old.salary);
    dbms_output.put_line('New salary: ' || :new.salary);
    dbms_output.put_line('Salary difference: ' || sal_diff);
END;
/

/*step 2*/
SET SERVEROUTPUT ON;

/*step 3 -- INSERT*/
INSERT INTO employees VALUES (employees_seq.nextval,'Aman','Pooja','123@gmail0com','0001112222',sysdate,'AD_PRES','20','','100','30');

/*step 4 -- UPDATE*/
UPDATE employees SET salary = 2000 
WHERE first_name = 'Aman'; 

/*step 5 -- DELETE*/
DELETE FROM employees
WHERE first_name = 'Aman';

/***************************/

/*  EX.2  */
/* step 1 -- Create Table*/
CREATE TABLE EMPLOYEES_LOG
(
    log_date DATE,
    action VARCHAR2(50),
    BY_USER VARCHAR2(50)
);

/* step 2 -- Create Triggers*/
CREATE OR REPLACE TRIGGER EMP_CHANGE_TRIGGER
AFTER INSERT OR UPDATE OR DELETE ON EMPLOYEES
DECLARE
    log_action EMPLOYEES_LOG.action%TYPE;
BEGIN
    IF INSERTING THEN
        log_action := 'Insert';
    ELSIF UPDATING THEN
        log_action := 'Update';
    ELSIF DELETING THEN
        log_action := 'Delete'; 
ELSE
        DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
    END IF;

INSERT INTO EMPLOYEES_LOG (log_date, action, BY_USER) VALUES (SYSDATE, log_action, ORA_LOGIN_USER);
END;
/

/*step 3 -- INSERT*/
INSERT INTO employees VALUES (employees_seq.nextval,'Aman','Pooja','123@gmail0com','0001112222',sysdate,'AD_PRES','20','','100','30');

/***************************/

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
    :NEW.COMMENTS_TITLE := REPLACE(UPPER(:NEW.COMMENTS_TITLE), 'TRABADSATY', 'ManKhong ManKhang Yangyuen');
    :NEW.COMMENTS_TITLE := REPLACE(UPPER(:NEW.COMMENTS_TITLE), 'NAI KOR SOM LON', 'Nai Kor Thanawat');
    :NEW.COMMENTS_TITLE := REPLACE(UPPER(:NEW.COMMENTS_TITLE), 'NAI KOR PITA', 'NaI Kor Thanawat');
END;
/
/*step 4*/
INSERT INTO COMMENTS VALUES('TrABaDsATY');
INSERT INTO COMMENTS VALUES('Nai kor Som Lon');
INSERT INTO COMMENTS VALUES('Nai kor Pita');



/***************************/

/*  EX.4  */
/* step 1 */
CREATE OR REPLACE PACKAGE my_package AS
    var1 NUMBER;
    var2 VARCHAR2(50);

    PROCEDURE pro1;
    FUNCTION fun1(param1 NUMBER) RETURN NUMBER;
END my_package;
/
/* step 2 */
CREATE OR REPLACE PACKAGE BODY my_package AS
    var1 NUMBER := 0;
    var2 VARCHAR2(50) := 'Hello';

    PROCEDURE pro1 IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Procedure 1 is called');
    END;

    FUNCTION fun1(param1 NUMBER) RETURN NUMBER IS
    BEGIN
       RETURN param1*10;
    END;
END my_package;
/
/* step 3 */
SET SERVEROUTPUT ON;
/* step 4 */
BEGIN
    DBMS_OUTPUT.PUT_LINE('Function result: ' || my_package.fun1(5));
END;
/

/***************************/

/*  EX.5  */
/*package header*/
CREATE OR REPLACE PACKAGE employee_mana AS
    FUNCTION add_employee(first_name VARCHAR2, 
                          last_name VARCHAR2,
                          email VARCHAR2,
                          PHONE_NUMBER VARCHAR2, 
                          JOB_ID VARCHAR2, 
                          salary NUMBER,
                          COMMISSION_PCT NUMBER,
                          MANAGER_ID NUMBER,
                          DEPARTMENT_ID NUMBER) 
        RETURN NUMBER;
    PROCEDURE remove_employee(employee_id NUMBER);
    PROCEDURE update_employee_salary(employee_id NUMBER, 
                                     salary NUMBER);
    PROCEDURE update_employee_commission_pct(employee_id NUMBER, 
                                             commission_pct NUMBER);
END employee_mana;
/

/**/
CREATE OR REPLACE PACKAGE BODY employee_mana AS
    /*add employee*/
  FUNCTION add_employee(first_name VARCHAR2, 
                          last_name VARCHAR2,
                          email VARCHAR2,
                          PHONE_NUMBER VARCHAR2, 
                          JOB_ID VARCHAR2, 
                          salary NUMBER,
                          COMMISSION_PCT NUMBER,
                          MANAGER_ID NUMBER,
                          DEPARTMENT_ID NUMBER) 
        RETURN NUMBER IS
  new_emp_id NUMBER;
  BEGIN
    new_emp_id := employees_seq.NEXTVAL;
    INSERT INTO employees
    VALUES (new_emp_id,
            first_name, 
            last_name, 
            email,
            PHONE_NUMBER,
            SYSDATE,
            JOB_ID,
            salary,
            COMMISSION_PCT,
            MANAGER_ID,
            DEPARTMENT_ID);
    dbms_output.put_line('New employee ID: ' || new_emp_id);
    RETURN new_emp_id;
  END add_employee;
    /*remove employee*/
    PROCEDURE remove_employee(employee_id NUMBER) IS
    BEGIN
        DELETE FROM employees
        WHERE employee_id = remove_employee.employee_id;
        dbms_output.put_line('Employee ID: ' || remove_employee.employee_id || ' has been removed');
    END remove_employee;
    /*update employee salary*/
    PROCEDURE update_employee_salary(employee_id NUMBER, 
                                     salary NUMBER) IS
    BEGIN
        UPDATE employees
        SET salary = update_employee_salary.salary
        WHERE employee_id = update_employee_salary.employee_id;
    END update_employee_salary;
    /*update employee commission*/
    PROCEDURE update_employee_commission_pct(employee_id NUMBER, 
                                             commission_pct NUMBER) IS
    BEGIN
        UPDATE employees
        SET commission_pct = update_employee_commission_pct.commission_pct
        WHERE employee_id = update_employee_commission_pct.employee_id;
    END update_employee_commission_pct;

END employee_mana;
/

DECLARE
  new_emp_id NUMBER(6);
BEGIN
    new_emp_id := employee_mana.add_employee('John', 'Doe', 'John@mail.com', '123456789', 'IT_PROG', 10000, 0.1, 100, 90);
    dbms_output.put_line('new_enp_id = ' || new_emp_id);
    employee_mana.update_employee_salary(new_emp_id, 20000);
    employee_mana.update_employee_commission_pct(new_emp_id, 0.2);
    employee_mana.remove_employee(new_emp_id);
END;
/   
