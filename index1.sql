EXPLAIN PLAN FOR 
    SELECT  * FROM EMP_LARGE WHERE DEPTNO in(10,20);

    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
    
    CREATE INDEX IDX_EMP_LARGE_DEPTNO ON EMP_LARGE(DEPTNO);
    
    drop index DEPTNO_LARGE;
    
    
