# 学员信息：姓名 性别  手机号
# 添加__str__ 查看学员信息

class Student(object):
    def __init__(self, name, gender, tel):
        self.name = name
        self.gender = gender
        self.tel = tel

    def __str__(self):
        return f'{self.name}, {self.gender}, {self.tel}'

# 测试code
# stu = Student('aa', 'nv', '137..')
# print(stu)



