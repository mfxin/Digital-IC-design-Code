# TODO:: 读取内容 写入内容 备份内容

# 打开一个已经存在的文件 或者创建一个新的文件
# f = open(name, mode) name : 文件名或具体路径  mode : 访问模式
f = open('test.txt', 'w')

# 文件对象.read()
# 文件对象.write('内容')
f.write('aaa')

# f.close()
f.close()




