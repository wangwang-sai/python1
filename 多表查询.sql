-- 1. 查出至少有一个员工的部门。显示部门编号、部门名称、部门位置、部门人数。
SELECT d.deptno, d.dname, d.loc, COUNT("renshu")
FROM t_dept d, t_employees e
WHERE e.deptno=d.deptno
/*内连接:*/
/*方言*/
SELECT e.`deptno`,d.`dname`, d.`loc` , COUNT(e.`deptno`)
FROM t_dept d, t_employees e
WHERE e.`deptno`=d.`deptno`
GROUP BY d.`deptno`;

/*标准写法*/
SELECT e.`deptno`,d.`dname`, d.`loc` , COUNT("renshu")
FROM  t_dept d INNER JOIN t_employees e
WHERE e.`deptno`=d.`deptno`
GROUP BY d.`deptno`

/*
2. 列出所有员工的姓名及其直接上级的姓名。
列：员工姓名、上级姓名
表：emp e, emp m
条件：员工的mgr = 上级的empno
*/
SELECT t.ename,d.ename
FROM t_employees t,t_employees d
WHERE t.MGR = d.empno

SELECT  t.ename,d.ename
FROM t_employees t LEFT JOIN t_employees d
ON t.MGR = d.empno  

/*
3. 列出受雇日期早于直接上级的所有员工的编号、姓名、部门名称。
列：e.empno, e.ename, d.dname
表：emp e, emp m, dept d
条件：e.hiredate<m.hiredate
思路：
1. 先不查部门名称，只查部门编号!
列：e.empno, e.ename, e.deptno
表：emp e, emp m
条件：e.mgr=m.empno, e.hiredate<m.hireadate
*/
SELECT  e.`empno`,e.`ename`,d.`dname`
FROM t_employees e ,t_employees m,t_dept d
WHERE e.`hiredate`< m.hiredate 
AND e.`MGR`=m.empno
AND e.`deptno`=d.`deptno`


/*
4. 列出部门名称和这些部门的员工信息，
同时列出那些没有员工的部门。
列：* 
表：emp e, dept d
条件：e.deptno=d.deptno
*/
SELECT *
FROM t_employees e,t_dept d
WHERE e.`deptno`=d.`deptno`

SELECT *
FROM t_employees e RIGHT OUTER JOIN t_dept d
ON e.deptno=d.deptno

/*
5. 列出最低薪金大于15000的各种工作
及从事此工作的员工人数。
列：job, count(*)
表：emp e
条件：min(sal) > 15000
分组：job
*/
SELECT job , COUNT(*)
FROM  t_employees
GROUP BY job
HAVING MIN(sal) >1500


/*
6. 列出在公关部工作的员工的姓名，
假定不知道公关部的部门编号。
列：e.ename
表：emp
条件：e.deptno=(select deptno from dept where dname='公关部')
*/
SELECT *  
FROM t_employees e
WHERE e.`deptno`=
(SELECT deptno FROM t_dept WHERE dname="公关部" )


/*
7. 列出薪金高于公司平均薪金的所有员工信息，
所在部门名称，上级领导，工资等级。
列：* 
表：emp e
条件：sal>(查询出公司的平均工资)
*/
-- 第一步：求出公司平均薪金
SELECT AVG(sal) FROM t_employees
-- 第二步：求薪金高于公司平均薪金的所有员工
SELECT * 
FROM t_employees 
WHERE sal > (SELECT AVG(sal) FROM t_employees)
-- 求员工所在部门，上级领导

SELECT e1.ename, e2.ename, d.dname e1.sal
FROM t_employees e1, t_employees e2, t_dept d
WHERE e1.mgr = e2.empno
AND e1.deptno = d.deptno;

-- 综合
SELECT e1.*,e2.`ename`, d.`dname`
FROM t_employees e1, t_employees e2, t_dept d
WHERE 
e1.`sal`> (SELECT AVG(sal)FROM t_employees)
AND e1.MGR = e2.empno
AND e1.deptno = d.deptno



/*
10.列出与张飞从事相同工作的所有员工及部门名称。
列：e.*, d.dname
表：emp e, dept d
条件：job=(查询出张飞的工作)
*/
SELECT e.ename,d.dname
FROM t_employees e
JOIN t_dept d ON e.deptno = d.deptno
WHERE e.job = (SELECT job FROM t_employees WHERE ename = "张飞")

/*
11.列出薪金高于在部门30工作的所有员工的薪金的员工姓名和薪金、部门名称。
列：e.ename, e.sal, d.dname
表：emp e, dept d
条件；sal>all (30部门薪金)
*/
/*SELECT e.ename, e.sal, d.dname
FROM emp e, dept d
WHERE e.deptno=d.deptno AND sal > ALL (SELECT sal FROM emp WHERE deptno=30)
*/
SELECT e.ename ,e.sal,d.`dname`
FROM t_employees e,t_dept d
WHERE e.deptno =d.`deptno` 
AND sal>ALL (SELECT sal FROM t_employees WHERE deptno=30)




















