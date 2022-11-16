"""
测试目标
1， r+ 和 w+
2. 文件指针对数据读取的影响
"""

f = open('test2.txt', 'r+')  # 不存在的文件会报错  文件指针再开头
con = f.read()
print(con)


# f = open('test2.txt', 'w+')  # 不存在的文件会创建

# f = open('test2.txt', 'w+')  # 用新内容覆盖旧内容 文件指针在开头
# con = f.read()
# print(con)

# f = open('test2.txt', 'a+')  # 不存在的文件会创建新文件 文件指针在结尾 也读不出来数据
# con = f.read()
# print(con)

f.close()




