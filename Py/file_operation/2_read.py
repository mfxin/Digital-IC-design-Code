# 文件对象.read(num)
f = open('read.txt', 'r')
# print(f.read())  # 读取所有内容
# print(f.read(5))  # 读取5个字节 换行占一个字节

# TODO:: readlines()
# con = f.readlines()
# print(con)

# TODO:: readline() 一次读取一行内容
con1 = f.readline()
print(con1)
con2 = f.readline()
print(con2)
con3 = f.readline()
print(con3)

f.close()
