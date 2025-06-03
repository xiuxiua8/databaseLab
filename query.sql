SELECT Cno, CNAME, CREDIT
FROM C126
WHERE Cno LIKE 'EE-%';

SELECT s.Sno, sc.Cno, sc.GRADE
FROM S126 s
         JOIN SC126 sc ON s.Sno = sc.Sno
WHERE s.SEX = '女'
  AND s.Sno NOT IN (SELECT Sno
                    FROM SC126
                    WHERE Cno = 'CS-02');


SELECT * FROM S126
WHERE BDATE BETWEEN '2004-01-01' AND '2005-12-31';

SELECT s.Sno, s.SNAME, SUM(c.CREDIT) AS TotalCredits
FROM S126 s
         JOIN SC126 sc ON s.Sno = sc.Sno
         JOIN C126 c ON sc.Cno = c.Cno
GROUP BY s.Sno, s.SNAME;

SELECT Sno
FROM SC126
WHERE Cno = 'CS-01'
ORDER BY GRADE DESC
OFFSET 1 LIMIT 1;

WITH AvgScores AS (
    SELECT s.Sno, s.SNAME, AVG(sc.GRADE) AS avg_grade
    FROM S126 s
             JOIN SC126 sc ON s.Sno = sc.Sno
    WHERE sc.GRADE IS NOT NULL
    GROUP BY s.Sno, s.SNAME
),
     WangTaoAvg AS (
         SELECT AVG(sc.GRADE) AS wt_avg
         FROM S126 s
                  JOIN SC126 sc ON s.Sno = sc.Sno
         WHERE s.SNAME = '王涛'
     )
SELECT a.Sno, a.SNAME, a.avg_grade
FROM AvgScores a, WangTaoAvg w
WHERE a.avg_grade > w.wt_avg
ORDER BY a.Sno DESC;

WITH CS_Courses AS (
    SELECT Cno FROM C126 WHERE Cno LIKE 'CS-%'
),
     Passed AS (
         SELECT Sno, COUNT(DISTINCT Cno) AS cnt
         FROM SC126
         WHERE Cno LIKE 'CS-%'
         GROUP BY Sno
     ),
     CS_Count AS (
         SELECT COUNT(*) AS total FROM CS_Courses
     )
SELECT s.SNAME, SUM(c.CREDIT) AS TotalCredits
FROM Passed p
         JOIN CS_Count cc ON p.cnt = cc.total
         JOIN S126 s ON s.Sno = p.Sno
         JOIN SC126 sc ON sc.Sno = p.Sno
         JOIN C126 c ON sc.Cno = c.Cno
GROUP BY s.SNAME;

WITH StudentAvg AS (
    SELECT s.Sno, s.SNAME, COUNT(*) AS cnt, AVG(GRADE) AS avg_grade
    FROM S126 s
             JOIN SC126 sc ON s.Sno = sc.Sno
    WHERE GRADE IS NOT NULL
    GROUP BY s.Sno, s.SNAME
    HAVING COUNT(*) >= 3
)
SELECT Sno, SNAME
FROM StudentAvg
ORDER BY avg_grade DESC
    LIMIT 1;
