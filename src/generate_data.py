from faker import Faker
import pandas as pd
import random

fake = Faker("zh_CN")
Faker.seed(126)
random.seed(126)

# 学生表
def generate_students(n=1000):
    data = []
    for _ in range(n):
        sno = fake.unique.random_int(min=10000000, max=99999999)
        sname = fake.name()
        sex = fake.random_element(elements=('男', '女'))
        bdate = fake.date_of_birth(minimum_age=18, maximum_age=25)
        height = round(random.uniform(1.50, 1.90), 2)
        dorm = f"东{random.randint(1,20)}舍{random.randint(100,499)}"
        data.append([sno, sname, sex, bdate, height, dorm])
    df = pd.DataFrame(data, columns=["Sno", "SNAME", "SEX", "BDATE", "HEIGHT", "DORM"])
    df.to_csv("resources/students.csv", index=False)

# 课程表
def generate_courses(n=100):
    cs_prefixes = ["计算机", "软件", "人工智能", "网络", "数据", "系统", "编译", "图形学", "算法"]
    cs_mids = ["基础", "原理", "系统", "架构", "方法", "模型"]
    cs_suffixes = ["导论", "实践", "设计", "实现", "开发", "分析", "优化"]

    ee_prefixes = ["电子", "电路", "信号", "通信", "控制", "嵌入式", "光电"]
    ee_mids = ["基础", "原理", "系统", "结构", "分析", "技术"]
    ee_suffixes = ["导论", "实验", "设计", "实现", "测试", "控制"]

    used_names = set()
    data = []

    while len(data) < n:
        if random.random() < 0.5:
            prefix = "CS"
            cname = random.choice(cs_prefixes) + random.choice(cs_mids) + random.choice(cs_suffixes)
        else:
            prefix = "EE"
            cname = random.choice(ee_prefixes) + random.choice(ee_mids) + random.choice(ee_suffixes)

        if cname in used_names:
            continue
        used_names.add(cname)

        cno = f"{prefix}-{len(data)+1:03d}"
        period = random.choice([40, 60, 80, 100])
        credit = period // 20
        teacher = fake.name()
        data.append([cno, cname, period, credit, teacher])

    df = pd.DataFrame(data, columns=["Cno", "CNAME", "PERIOD", "CREDIT", "TEACHER"])
    df.to_csv("resources/courses.csv", index=False)

# 选课表
def generate_sc(students, courses, m=20000):
    data = []
    for _ in range(m):
        sno = random.choice(students)
        cno = random.choice(courses)
        grade = random.choice([None] + [round(random.uniform(40, 100), 1)] * 5)
        data.append([sno, cno, grade])
    df = pd.DataFrame(data, columns=["Sno", "Cno", "GRADE"])
    df.to_csv("resources/sc.csv", index=False)

# 生成
generate_students(1000)
generate_courses(100)
students = pd.read_csv("resources/students.csv")["Sno"].tolist()
courses = pd.read_csv("resources/courses.csv")["Cno"].tolist()
generate_sc(students, courses, 20000)
