"""
# 需求：存储数据的位置：文件（student.data）
# 加载文件数据
# 修改数据后保存到文件
# 存储数据的形式 列表
# 系统功能
 添加学员
 删除
 修改
 查询
 显示
 保存
# 步骤：
程序入口函数
    加载数据
    显示功能菜单
    用户输入功能序号
    根据用户输入的功能序号执行不同的功能

系统功能函数：添加、删除、等
"""
from student import *

class StudentManger(object):
    def __init__(self):
        # 存储数据所用的列表
        self.student_list = []
    # 程序入口函数
    def run(self):
        # 1.加载学员信息  不需要循环执行
        self.load_student()
        while True:
            # 2.显示菜单
            self.show_menu()
            # 3.用户输入功能序号
            id = int(input("请输入功能序号："))
            if id == 1:
                # 添加学员
                self.add_student()
            elif id == 2:
                # 删除学员
                self.del_student()
            elif id == 3:
                # 修改学员信息
                self.modify_student()
            elif id == 4:
                # 查询学员信息
                self.search_student()
            elif id == 5:
                # 显示所有学员信息
                self.show_student()
            elif id == 6:
                # 保存学员信息
                self.save_student()
            elif id == 7:
                # 退出系统(退出循环)
                break
    # 定义系统功能函数
    # 显示功能菜单
    @staticmethod
    def show_menu():
        print("请选择如下功能：")
        print("1：添加学员")
        print("2：删除学员")
        print("3：修改学员信息")
        print("4：查询学员信息")
        print("5：显示所有学员信息")
        print("6：保存学员信息")
        print("7：退出系统")
    # 添加学员
    def add_student(self):
        name = input("请输入您的姓名：")
        gender = input('请输入您的性别：')
        tel = input('请输入您的手机号：')
        student = Student(name, gender, tel)
        self.student_list.append(student)
        print(self.student_list)
        print(student)

    # 删除学员
    def del_student(self):
        name = input('请输入需要删除的学员姓名：')
        for i in self.student_list:
            if i.name == name:
                self.student_list.remove(i)
                break
        else:
            print("查无此人")
        print(self.student_list)
    # 修改学员信息
    def modify_student(self):
        name = input('请输入要修改的学生姓名：')
        for i in self.student_list:
            if i.name == name:
                i.name = input("请输入学员姓名：")
                i.gender = input('请输入学员性别：')
                i.tel = input('请输入学员手机号：')
                print('修改成功')
                break
        # 若for循环内部没有正常执行 则执行下面的else
        else:
            print('查无此人')
    # 查询学员信息
    def search_student(self):
        name = input('输入需要搜素的学员姓名：')
        for i in self.student_list:
            if i.name == name:
                print(f"{i.name}, {i.gender}, {i.tel}")
                break
        else:
            print("查无此人")
    # 显示所有学员信息
    def show_student(self):
        print('姓名\t性别\t手机号')
        for i in self.student_list:
            print(f'{i.name}\t{i.gender}\t{i.tel}')
    # 保存学员信息
    def save_student(self):
        f = open('student.data', 'w')
        new_list = [i.__dict__ for i in self.student_list] # __dict__ 返回一个实例属性的字典
        print(new_list)
        f.write(str(new_list))
        f.close()
    # 加载文件学员信息
    def load_student(self):
        try:
            f = open('student.data', 'r')
            print('只读模式 打开数据文件。。')
        except:
            f = open('student.data', 'w')
            print('写入模式 打开数据文件。。')
        else:
            data = f.read()
            new_list = eval(data)  # data 是字符串 eval的作用就是去掉字符串的引号，转换为列表
            self.student_list = [Student(i['name'], i['gender'], i['tel']) for i in new_list]
            print('数据列表已更新')
        finally:
            f.close()


