# TODO::当方法中需要使用类对象访问私有类属性时，定义类方法，类方法一般和类属性配合使用
# 定义类，私有类属性，类方法获取私有类属性
class Dog():
    __tooth = 10

    @classmethod   # 装饰器
    def get_tooth(cls):
        return cls.__tooth


# 创建对象，调用类方法
wangcai = Dog()
result = wangcai.get_tooth()
print(result)


# TODO::静态方法，不需要传参
# TODO:: 可以减少不必要的内存消耗
class Dog1():
    @staticmethod   # 装饰器
    def info_print():
        print("这是一个静态方法")


dog = Dog1()
dog.info_print()
