class House():
    def __init__(self, weizhi, housezhandimianji):
        self.weizhi = weizhi
        self.housezhandimianji  = housezhandimianji
        self.shengyumianji = housezhandimianji
        self.jiajuliebiao = []
    def rongnajiaju(self, jiaju):
        if jiaju.area <= self.shengyumianji:
            self.jiajuliebiao.append(jiaju.name)
            self.shengyumianji -= jiaju.area
        else:
            print("家具太大，装不下")
    def __str__(self):
        return f"房子在{self.weizhi},占地面积{self.housezhandimianji}平米,剩余面积{self.shengyumianji}平,有家具{self.jiajuliebiao}"
class JiaJu():
    def __init__(self, name, area):
        self.name = name
        self.area = area

sofa = JiaJu("沙发",6)
bed = JiaJu("床",10)

house1 = House("西安",100)
print(house1)
house1.rongnajiaju(sofa)
print(house1)
house1.rongnajiaju(bed)
print(house1)

