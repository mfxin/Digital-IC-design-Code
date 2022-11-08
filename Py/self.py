class Washer():
    def wash(self):  #调用该函数的对象
        print("洗衣服")
        print(self)  #打印该对象  == print(haier)
    def print_info(self):
        #self.属性
        print(f'洗衣机的高度是{self.height}')
        print(f'洗衣机的宽度是{self.width}')
#创建对象
haier1 = Washer()
haier2 = Washer()
print(haier1)
print(haier2) #地址不同

#为对象在类外面 添加属性
haier1.width = 500
haier1.height = 400
#print(f'洗衣机的高度是{haier1.height}')
haier1.wash()
haier1.print_info()
#类里面添加属性
