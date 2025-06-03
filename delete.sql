DELETE FROM S126
WHERE Sno IN (
    SELECT sc.Sno
    FROM SC126 sc
             JOIN C126 c ON sc.Cno = c.Cno
    GROUP BY sc.Sno
    HAVING SUM(c.CREDIT) > 60
);
