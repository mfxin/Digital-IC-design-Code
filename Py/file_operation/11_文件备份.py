old_name = input('请输入需要备份的文件名：')
index = old_name.rfind('.')
if index > 0:   # 避免出现非法文件名 .txt
    postfix = old_name[index:]
new_name = old_name[:index] + '[备份]'
print(new_name)
f_b = open(new_name+postfix, 'w+')
f = open(old_name, 'r+')
con = f.read()
f_b.write(con)
f.close()
f_b.close()