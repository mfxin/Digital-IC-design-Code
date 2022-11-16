#定义类 ：初始化属性  被烤和添加调料的方法  显示对象信息
class Digua():
    def __init__(self):
        #考的时间
        self.time = 0
        #地瓜状态
        self.state = "生的"
        # 调料列表
        self.condiments = []
    def cook(self, time):
        self.time += time  #每次考的时间的总和
        if  self.time>=0 and self.time < 3:
            self.state = "生的"
        elif 3<= self.time < 5:
            self.state = "半生不熟"
        elif 5<= self.time < 8:
            self.state = "熟的"
        elif self.time >= 8:
            self.state = "糊了"
    def __str__(self):
        return f"地瓜{self.state},烤了{self.time}分钟，调料为{self.condiments}"
    def add_condiments(self,cons):
        self.condiments.append(cons)  #向调料列表里面添加调料

#创建对象
digua1 = Digua()
print(digua1)
digua1.cook(2)
print(digua1)
digua1.cook(2)
print(digua1)
digua1.cook(2)
print(digua1)
digua1.cook(2)
print(digua1)
print()
digua1.add_condiments("辣椒面")
print(digua1)