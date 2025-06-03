CREATE TABLE IF NOT EXISTS S126 (
                                    Sno VARCHAR(10) PRIMARY KEY,
    SNAME VARCHAR(20),
    SEX CHAR(4),
    BDATE DATE,
    HEIGHT DECIMAL(4,2),
    DORM VARCHAR(50)
    );
CREATE TABLE IF NOT EXISTS C126 (
                                    Cno VARCHAR(10) PRIMARY KEY,
    CNAME VARCHAR(50),
    PERIOD INT,
    CREDIT INT,
    TEACHER VARCHAR(20)
    );
CREATE TABLE IF NOT EXISTS SC126 (
                                     Sno VARCHAR(10),
    Cno VARCHAR(10),
    GRADE DECIMAL(5,2),
    PRIMARY KEY (Sno, Cno),
    FOREIGN KEY (Sno) REFERENCES S126(Sno),
    FOREIGN KEY (Cno) REFERENCES C126(Cno)
    );

INSERT INTO S126 VALUES
                     ('01032010', '王涛', '男', '2003-04-05', 1.72, '东6舍221'),
                     ('01032023', '孙文', '男', '2004-06-10', 1.80, '东6舍221'),
                     ('01032001', '张晓梅', '女', '2003-11-17', 1.58, '东1舍312'),
                     ('01032005', '刘静', '女', '2003-01-10', 1.63, '东1舍312'),
                     ('01032112', '董喆', '男', '2003-02-20', 1.71, '东6舍221'),
                     ('03031011', '王倩', '女', '2004-12-20', 1.66, '东2舍104'),
                     ('03031014', '赵思扬', '男', '2002-06-06', 1.85, '东18舍421'),
                     ('03031051', '周剑', '男', '2002-05-08', 1.68, '东18舍422'),
                     ('03031009', '田菲', '女', '2003-08-11', 1.60, '东2舍104'),
                     ('03031033', '蔡明明', '男', '2003-03-12', 1.75, '东18舍423'),
                     ('03031056', '曹子衿', '女', '2005-12-15', 1.65, '东2舍305');

INSERT INTO C126 VALUES
                     ('CS-01', '数据结构', 60, 3, '张军'),
                     ('CS-02', '计算机组成原理', 80, 4, '王亚伟'),
                     ('CS-04', '人工智能', 40, 2, '李蕾'),
                     ('CS-05', '深度学习', 40, 2, '崔昀'),
                     ('EE-01', '信号与系统', 60, 3, '张明'),
                     ('EE-02', '数字逻辑电路', 100, 5, '胡海东'),
                      ('EE-03', '光电子学与光子学', 40, 2, '石韬');

INSERT INTO SC126 VALUES ('01032010', 'CS-01', 82.0);
INSERT INTO SC126 VALUES ('01032010', 'CS-02', 91.0);
INSERT INTO SC126 VALUES ('01032010', 'CS-04', 83.5);

INSERT INTO SC126 VALUES ('01032001', 'CS-01', 77.5);
INSERT INTO SC126 VALUES ('01032001', 'CS-02', 85.0);
INSERT INTO SC126 VALUES ('01032001', 'CS-04', 83.0);

INSERT INTO SC126 VALUES ('01032005', 'CS-01', 62.0);
INSERT INTO SC126 VALUES ('01032005', 'CS-02', 77.0);
INSERT INTO SC126 VALUES ('01032005', 'CS-04', 82.0);

INSERT INTO SC126 VALUES ('01032023', 'CS-01', 55.0);
INSERT INTO SC126 VALUES ('01032023', 'CS-02', 81.0);
INSERT INTO SC126 VALUES ('01032023', 'CS-04', 76.0);

INSERT INTO SC126 VALUES ('01032112', 'CS-01', 88.0);
INSERT INTO SC126 VALUES ('01032112', 'CS-02', 91.5);
INSERT INTO SC126 VALUES ('01032112', 'CS-04', 86.0);
INSERT INTO SC126 VALUES ('01032112', 'CS-05', NULL);

INSERT INTO SC126 VALUES ('03031033', 'EE-01', 93.0);
INSERT INTO SC126 VALUES ('03031033', 'EE-02', 89.0);

INSERT INTO SC126 VALUES ('03031009', 'EE-01', 88.0);
INSERT INTO SC126 VALUES ('03031009', 'EE-02', 78.5);

INSERT INTO SC126 VALUES ('03031011', 'EE-01', 91.0);
INSERT INTO SC126 VALUES ('03031011', 'EE-02', 86.0);

INSERT INTO SC126 VALUES ('03031051', 'EE-01', 78.0);
INSERT INTO SC126 VALUES ('03031051', 'EE-02', 58.0);

INSERT INTO SC126 VALUES ('03031014', 'EE-01', 79.0);
INSERT INTO SC126 VALUES ('03031014', 'EE-02', 71.0);
