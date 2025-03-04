SELECT * FROM EMP_LARGE;

SELECT * FROM DEPT_LARGE;

SELECT * FROM SALGRADE_LARGE;
======================================================
Index Optimization (Basic)
--Find all employees with the job 'SALESMAN'.
    SELECT * FROM EMP_LARGE WHERE JOB='SALESMAN';
    
    CREATE INDEX JOB_LARGE ON EMP_LARGE(JOB);

    EXPLAIN PLAN FOR
    SELECT /*+ INDEX(EMP_LARGE JOB_LARGE) */ * FROM EMP_LARGE WHERE JOB='SALESMAN';
    
    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
========================================================
--Fetch employees from department 30.
    SELECT * FROM EMP_LARGE WHERE DEPTNO=30;
   
   CREATE INDEX IDX_EMP_LARGE_DEPTNO ON EMP_LARGE(DEPTNO);
   
    EXPLAIN PLAN FOR 
    SELECT  /*+ INDEX(EMP_LARGE IDX_EMP_LARGE_DEPTNO) */ * FROM EMP_LARGE WHERE DEPTNO in(10,20);

    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
    
=====================================================
--Optimize salary range queries (Index on SAL)
    SELECT * FROM  EMP_LARGE WHERE SAL BETWEEN 1000 AND 3000;
    
    CREATE INDEX SAL_LARGE ON EMP_LARGE(SAL);
    DROP INDEX SAL_LARGE;
    
    EXPLAIN PLAN FOR
    SELECT /*+INDEX (EMP_LARGE SAL_LARGE) */ * FROM EMP_LARGE WHERE SAL BETWEEN 1000 AND 3000;
    
    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
======================================================
--Analyze execution plan for employee joins with department.
    EXPLAIN PLAN FOR
    SELECT /*+INDEX (EMP_LARGE DEPTNO_LARGE) */ E.EMPNO,E.ENAME,D.DNAME,D.LOC FROM 
    EMP_LARGE E JOIN DEPT_LARGE D ON E.DEPTNO=D.DEPTNO;
    
    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
===========================================================
 Find top 5 highest paid employees efficiently.
    EXPLAIN PLAN FOR
    SELECT  * FROM EMP_LARGE ORDER BY SAL DESC FETCH FIRST 5 ROWS ONLY;
    
    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
 
============================================================
--Optimize searches by JOB and DEPTNO together.
    CREATE INDEX JOB_DEPTNO ON EMP_LARGE(JOB,DEPTNO);

    EXPLAIN PLAN FOR
    SELECT /*+INDEX (EMP_LARGE JOB_DEPTNO)  */ * FROM EMP_LARGE WHERE JOB='CLERK' AND DEPTNO=10;
 
    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
==============================================================
--Retrieve employees without NULL values in COMM.
    CREATE INDEX idx_emp_comm_not_null ON EMP (COMM);


    EXPLAIN PLAN FOR
    SELECT * FROM EMP_LARGE WHERE COMM IS NOT NULL;

    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
    
=============================================================
CREATE INDEX IDX_EMP_LARGE_ENAME ON EMP_LARGE(ENAME);


EXPLAIN PLAN FOR
SELECT * FROM EMP_LARGE WHERE ENAME='EMP_501';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

===============================================================
CREATE INDEX IDX_DEPTNO_SAL ON EMP_LARGE(DEPTNO,SAL);

EXPLAIN PLAN FOR
    SELECT /*+ INDEX(EMP_LARGE IDX_DEPTNO_SAL) */ * FROM EMP_LARGE WHERE DEPTNO IN(10,20) AND SAL BETWEEN 1000 AND 3000;
    
    SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT INDEX_NAME FROM USER_INDEXES WHERE TABLE_NAME='EMP_LARGE';
===================================================