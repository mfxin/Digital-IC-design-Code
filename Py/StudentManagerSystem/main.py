# 系统要求：学员数据保存再文件中
# 系统功能：添删改查，显示，保存，退出体统
# 角色分析：学员  管理系统
# TODO：：为了方便维护代码，一般一个角色一个程序文件，项目要有主程序入口（main.py）

from managerSystem import *

if __name__ == '__main__':
    student_manager = StudentManger()
    student_manager.run()