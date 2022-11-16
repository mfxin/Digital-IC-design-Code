#需求：洗衣机 功能：能洗衣服
#1 定义类
class Washer():
    def wash(self):
        print("能洗衣服")

#2 创建对象
haier = Washer()

#3 验证功能
#打印对象
print(haier)
#使用类内函数  实例方法
haier.wash()