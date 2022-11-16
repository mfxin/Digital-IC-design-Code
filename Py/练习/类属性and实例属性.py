# TODO:: 记录某项数据 始终保持一致时，则定义类属性，为全类所共有 仅占一份内存 更加节省内存空间
# TODO:: 类熟悉只能通过类修改 不能通过对象修改，如果通过对象修改，表示的是创建了一个实例属性
class Dog():
    tooth = 10  # 定义一个类属性


# 创建对象
wangcai = Dog()
xiaohei = Dog()
# 访问类属性
wangcai.tooth = 5  # 通过对象修改类属性 创建了一个实例属性
print(Dog.tooth)  # 10
print(wangcai.tooth)  # 5
print(xiaohei.tooth)  # 10

# 通过类修改类属性 修改了类属性
Dog.tooth = 20
print(Dog.tooth)  # 20
print(wangcai.tooth)  # 5, 因为前面通过对象创建了一个实例属性，所以这里的tooth不是类里面的tooth
print(xiaohei.tooth)  # 20

