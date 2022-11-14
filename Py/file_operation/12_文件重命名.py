import os

list = os.listdir()
print(list)


i = 1

for name in list:
    os.rename(name, str(i)+'_'+name)
    i = i+1
#
# print(os.listdir('test'))

list = os.listdir()
print(list)


