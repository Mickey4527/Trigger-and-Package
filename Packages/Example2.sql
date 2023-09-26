/*  EX.5  */
/*package header*/
CREATE OR REPLACE PACKAGE employee_mana AS
    FUNCTION add_employee(first_name Employee.first_name%TYPE,, 
                          last_name Employee.last_name%TYPE,
                          email Employee.email%TYPE,
                          PHONE_NUMBER Employee.PHONE_NUMBER%TYPE,, 
                          JOB_ID Employee.JOB_ID%TYPE,, 
                          salary Employee.salary%TYPE,
                          COMMISSION_PCT Employee.COMMISSION_PCT%TYPE,
                          MANAGER_ID Employee.MANAGER_ID%TYPE,
                          DEPARTMENT_ID Employee.DEPARTMENT_ID%TYPE) 
        RETURN NUMBER;
    PROCEDURE remove_employee(employee_id Employee.employee_id%TYPE);
    PROCEDURE update_employee_salary(employee_id Employee.employee_id%TYPE, 
                                     salary Employee.salary%TYPE);
    PROCEDURE update_employee_commission_pct(employee_id Employee.employee_id%TYPE, 
                                             commission_pct Employee.COMMISSION_PCT%TYPE);
END employee_mana;
/

/*package body*/
CREATE OR REPLACE PACKAGE BODY employee_mana AS
/*add employee*/
  FUNCTION add_employee(first_name Employee.first_name%TYPE,, 
                          last_name Employee.last_name%TYPE,
                          email Employee.email%TYPE,
                          PHONE_NUMBER Employee.PHONE_NUMBER%TYPE,, 
                          JOB_ID Employee.JOB_ID%TYPE,, 
                          salary Employee.salary%TYPE,
                          COMMISSION_PCT Employee.COMMISSION_PCT%TYPE,
                          MANAGER_ID Employee.MANAGER_ID%TYPE,
                          DEPARTMENT_ID Employee.DEPARTMENT_ID%TYPE) 

        RETURN NUMBER IS new_emp_id NUMBER;

  BEGIN
   
  END add_employee;

/*remove employee*/
    PROCEDURE remove_employee(employee_id Employee.employee_id%TYPE) IS
   
    END remove_employee;

/*update employee salary*/
  

/*update employee commission*/
    PROCEDURE update_employee_commission_pct(employee_id Employee.employee_id%TYPE, 
                                             commission_pct Employee.COMMISSION_PCT%TYPE) IS
    BEGIN
   
    END update_employee_commission_pct;

END employee_mana;
/

/*test*/
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

