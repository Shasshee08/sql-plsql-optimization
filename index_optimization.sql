SELECT * FROM EMP_LARGE;

SELECT * FROM DEPT_LARGE;

SELECT * FROM SALGRADE_LARGE;

CREATE INDEX IDX_DEPTNO_EMP_LARGE ON EMP_LARGE(DEPTNO);

EXPLAIN PLAN FOR
SELECT * FROM EMP_LARGE WHERE DEPTNO IN(10,20);

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);