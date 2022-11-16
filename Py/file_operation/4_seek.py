"""
f.seek(偏移量, 起始位置) 0：开头 1：当前 2：结尾
"""
f = open('test2.txt', 'a+')
f.seek(0, 0)
con = f.read()
print(con)

f.close()




