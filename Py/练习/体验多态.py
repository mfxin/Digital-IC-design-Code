# 需求：警务人员和警犬一起工作，警犬分两种，追击敌人 和 追查毒品，携带不同的警犬，执行不同的工作
# 定义父类，提供公共方法：警犬和人
class Dog():
    def work(self):
        # print("指哪打哪。。。")
        pass


class Person():
    def work_with_dog(self, dog):
        dog.work()


# 定义子类， 子类重写父类方法
class ArmyDog(Dog):
    def work(self):
        print("追击敌人...")


class DrugDog(Dog):
    def work(self):
        print("追击毒品...")


ad = ArmyDog()
dd = DrugDog()
daqiu = Person()
daqiu.work_with_dog(ad)
daqiu.work_with_dog(dd)

