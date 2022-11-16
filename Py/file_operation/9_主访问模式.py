"""
测试目标
1. 访问模式对文件的影响
2. 访问模式对write()的影响
3. 访问模式是否可以省略
"""

# r : 只读
# f = open('test1.txt', 'r')  # 只读模式打开不存的文件会报错
f = open('5_test.txt', 'r')

a = f.readlines()
print(a)
f.close()

# # w : 只写
# f = open('test1.txt', 'w')  # 如果文件不存在 会创建新文件
# f.write('ba')  # 会覆盖原有内容
# f.close()
#
# # a: 如果文件不存在 会创建新文件 在原有内容上追加新内容
# f = open('test1.txt', 'a')
# f.write('halal')  # 会覆盖原有内容
# f.close()
#
# # 访问模式可以省略 默认为”r“
# f = open('test.txt')
# f.close()
