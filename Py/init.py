class Washer():
    #初始化对象
    def __init__(self,width,height):   #创建的对象不用单独调用  默认执行
        self.width = width
        self.height = height

    def print_info(self):
        print(f'洗衣机的高度是{self.height},宽度是{self.width}')

haier = Washer(10,20)  #在实例化的时候给init传参数
haier.print_info()
haier2 = Washer(100,200)
haier2.print_info()