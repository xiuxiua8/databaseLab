
EXPLAIN ANALYZE
WITH cs_courses AS (
    SELECT Cno FROM C126 WHERE Cno LIKE 'CS-%'
),
     student_counts AS (
         SELECT sc.Sno, COUNT(DISTINCT sc.Cno) AS cnt
         FROM SC126 sc
         WHERE sc.Cno LIKE 'CS-%'
         GROUP BY sc.Sno
     ),
     cs_total AS (
         SELECT COUNT(*) AS total FROM cs_courses
     )
SELECT s.SNAME, SUM(c.CREDIT)
FROM student_counts st
         JOIN cs_total ct ON st.cnt = ct.total
         JOIN S126 s ON s.Sno = st.Sno
         JOIN SC126 sc ON sc.Sno = st.Sno
         JOIN C126 c ON sc.Cno = c.Cno
GROUP BY s.SNAME;


EXPLAIN ANALYZE
SELECT s.SNAME, SUM(c.CREDIT)
FROM S126 s
         JOIN SC126 sc ON s.Sno = sc.Sno
         JOIN C126 c ON sc.Cno = c.Cno
WHERE NOT EXISTS (
    SELECT 1 FROM C126 c2
    WHERE c2.Cno LIKE 'CS-%'
      AND NOT EXISTS (
        SELECT 1 FROM SC126 sc2
        WHERE sc2.Sno = s.Sno AND sc2.Cno = c2.Cno
    )
)
GROUP BY s.SNAME;


EXPLAIN ANALYZE
WITH WangTaoAvg AS (
    SELECT AVG(GRADE) AS wt_avg
    FROM S126 s JOIN SC126 sc ON s.Sno = sc.Sno
    WHERE s.SNAME = '王涛'
)
SELECT s.Sno, s.SNAME, AVG(sc.GRADE) AS avg_grade
FROM S126 s
         JOIN SC126 sc ON s.Sno = sc.Sno
GROUP BY s.Sno, s.SNAME
HAVING AVG(sc.GRADE) > (SELECT wt_avg FROM WangTaoAvg);


EXPLAIN ANALYZE
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


EXPLAIN ANALYZE
SELECT Sno
FROM SC126
WHERE Cno = 'CS-01' AND GRADE IS NOT NULL
ORDER BY GRADE DESC
OFFSET 1 LIMIT 1;

EXPLAIN ANALYZE
SELECT Sno
FROM SC126
WHERE Cno = 'CS-01' AND GRADE < (
    SELECT MAX(GRADE)
    FROM SC126
    WHERE Cno = 'CS-01'
)
ORDER BY GRADE DESC
LIMIT 1;
