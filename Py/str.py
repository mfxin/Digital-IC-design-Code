class Washer():
    #初始化对象 并设定默认值
    def __init__(self,width=100,height=200):   #创建的对象不用单独调用  默认执行
        self.width = width
        self.height = height
    def __str__(self):
        return "这是一台洗衣机"
    def print_info(self):
        print(f'洗衣机的高度是{self.height},宽度是{self.width}')

haier = Washer(20,30)
print(haier)