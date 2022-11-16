# 子类默认继承父类的所有属性和方法
# 定义父类
# class A():
#     def __init__(self):
#         self.num = 1
#
#     def info_print(self):
#         print(self.num)
#
#
# # 定义子类 继承父类
# class B(A):
#     pass  # 没有内容


# # 创建对象 验证结论
# result = B()
# result.num = 10
# result.info_print()


# TODO::单继承
# class Master(object):
#     def __init__(self):
#         self.kongfu = "[古法煎饼果子配方]"
#     def make_cake(self):
#         print(f"运用{self.kongfu}")
#
# class Prentice(Master):
#     pass
#
# daqiu = Prentice()
# print(daqiu.kongfu)
# daqiu.make_cake()

# TODO:: 多继承
#
# class Master(object):
#     def __init__(self):
#         self.kongfu = "[古法煎饼果子配方]"
#
#     def make_cake(self):
#         print(f"运用{self.kongfu}")
#
#
# # 创建学校类
# class School():
#     def __init__(self):
#         self.kongfu = "[西电煎饼果子配方]"
#
#     def make_cake(self):
#         print(f"运用{self.kongfu}")
#
#
# class Prentice(School, Master):  # TODO::继承多个父类的时候 同名方法和属性默认继承第一个父类的
#     pass
#
#
# daqiu = Prentice()
# print(daqiu.kongfu)
# daqiu.make_cake()


# TODO:: 子类重写父类同名属性和方法
#
# class Master(object):
#     def __init__(self):
#         self.kongfu = "[古法煎饼果子配方]"
#
#     def make_cake(self):
#         print(f"运用{self.kongfu}")
#
#
# # 创建学校类
# class School():
#     def __init__(self):
#         self.kongfu = "[西电煎饼果子配方]"
#
#     def make_cake(self):
#         print(f"运用{self.kongfu}")
#
#
# class Prentice(School, Master):  # TODO::如果子类中有父类的同名属性和方法，默认调用自己的属性和方法
#     def __init__(self):
#         self.kongfu = "[独创煎饼果子配方]"
#
#     def make_cake(self):
#         print(f"运用{self.kongfu}")
#
#
# daqiu = Prentice()
# print(daqiu.kongfu)
# daqiu.make_cake()
# print(Prentice.__mro__)  # 打印这个类的继承关系

# # TODO::子类调用父类的同名方法和属性
# class Master(object):
#     def __init__(self):
#         self.kongfu = "[古法煎饼果子配方]"
#
#     def make_cake(self):
#         print(f"运用{self.kongfu}")
#
#
# # 创建学校类
# class School():
#     def __init__(self):
#         self.kongfu = "[西电煎饼果子配方]"
#
#     def make_cake(self):
#         print(f"运用{self.kongfu}")
#
#
# class Prentice(School, Master):  # 如果子类中有父类的同名属性和方法，默认调用自己的属性和方法
#     def __init__(self):
#         self.kongfu = "[独创煎饼果子配方]"
#
#     def make_cake(self):
#         self.__init__()  # 为了避免调用该方法的时候，功夫属性值为上一次调用的init属性值  不一定是自己的
#         print(f"运用{self.kongfu}")
#
#     def make_master_cake(self):
#         Master.__init__(self)  # 父类的同名属性在父类的初始化部分，所以需要再次调用 init
#         Master.make_cake(self)
#
#     def make_school_cake(self):
#         School.__init__(self)
#         School.make_cake(self)
#
#
# # 多层继承
# class Tusun(Prentice):
#     pass
#
#
# daqiu = Prentice()
# # print(daqiu.kongfu)
# daqiu.make_cake()
# daqiu.make_master_cake()
# daqiu.make_school_cake()
# daqiu.make_cake()
# print(Prentice.__mro__)  # TODO::打印这个类的继承关系
#
# tusun = Tusun()
# tusun.make_school_cake()
# tusun.make_cake()

# TODO::super() 子类调用父类的同名方法和属性
# class Master(object):
#     def __init__(self):
#         self.kongfu = "[古法煎饼果子配方]"
#
#     def make_cake(self):
#         print(f"运用{self.kongfu}")
#
#
# # 创建学校类
# class School(Master):
#     def __init__(self):
#         self.kongfu = "[西电煎饼果子配方]"
#
#     def make_cake(self):
#         print(f"运用{self.kongfu}")
#         # super(School, self).__init__()
#         # super(School, self).make_cake()
#         super().__init__()
#         super().make_cake()
#
#
# class Prentice(School):  # 如果子类中有父类的同名属性和方法，默认调用自己的属性和方法
#     def __init__(self):
#         self.kongfu = "[独创煎饼果子配方]"
#
#     def make_cake(self):
#         self.__init__()  # 为了避免调用该方法的时候，功夫属性值为上一次调用的init属性值  不一定是自己的
#         print(f"运用{self.kongfu}")
#
#     def make_master_cake(self):
#         Master.__init__(self)  # 父类的同名属性在父类的初始化部分，所以需要再次调用 init
#         Master.make_cake(self)
#
#     def make_school_cake(self):
#         School.__init__(self)
#         School.make_cake(self)
#
#     def make_old_cake(self):
#         # 方法1：
#         # School.__init__(self)
#         # School.make_cake(self)
#         # Master.__init__(self)
#         # Master.make_cake(self)
#
#         # 方法2：super()
#         # super(Prentice, self).__init__()
#         # super(Prentice, self).make_cake()
#
#         # 方法3：无参数的super()
#         super().__init__()
#         super().make_cake()
#
#
# daqiu = Prentice()
# daqiu.make_old_cake()
#
# print(Prentice.__mro__)

# TODO::设置私有属性和方法   ：：在属性或方法名前面加下划线
class Master(object):
    def __init__(self):
        self.kongfu = "[古法煎饼果子配方]"

    def make_cake(self):
        print(f"运用{self.kongfu}")


# 创建学校类
class School(Master):
    def __init__(self):
        self.kongfu = "[西电煎饼果子配方]"

    def make_cake(self):
        print(f"运用{self.kongfu}")
        # super(School, self).__init__()
        # super(School, self).make_cake()
        super().__init__()
        super().make_cake()


class Prentice(School):  # 如果子类中有父类的同名属性和方法，默认调用自己的属性和方法
    def __init__(self):
        self.kongfu = "[独创煎饼果子配方]"
        self.__money = 200  #定于私有属性 不能继承给子类

    # 获取私有属性
    def get_money(self):
        return self.__money

    # 修改私有属性
    def set_money(self, money):
        self.__money = money

    def __info_print(self):  #定义私有函数  不继承给子类
        print(f"有{self.__money}亿")

    def make_cake(self):
        self.__init__()  # 为了避免调用该方法的时候，功夫属性值为上一次调用的init属性值  不一定是自己的
        print(f"运用{self.kongfu}")

    def make_master_cake(self):
        Master.__init__(self)  # 父类的同名属性在父类的初始化部分，所以需要再次调用 init
        Master.make_cake(self)

    def make_school_cake(self):
        School.__init__(self)
        School.make_cake(self)

    def make_old_cake(self):
        # 方法1：
        # School.__init__(self)
        # School.make_cake(self)
        # Master.__init__(self)
        # Master.make_cake(self)

        # 方法2：super()
        # super(Prentice, self).__init__()
        # super(Prentice, self).make_cake()

        # 方法3：无参数的super()
        super().__init__()
        super().make_cake()


class Tusun(Prentice):
    pass


xiaoqiu = Tusun()

print(xiaoqiu.get_money())
xiaoqiu.set_money(500)
print(xiaoqiu.get_money())

# print(xiaoqiu.__money)  #报错 没有继承私有属性
# xiaoqiu.__info_print()  #报错 没有继承私有方法




