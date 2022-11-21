# 检索和替换
# re.sub(pattern, repl, string, count=0, flags=0)
# repl 替换的字符串 也可为一个函数
# count 模式匹配后替换的最大次数 默认0 表示替换所有的匹配

import re

phone = '2004-959-559 # 这是一个国外电话号码'
num = re.sub(pattern='#.*', repl='', string=phone, count=0, flags=0)
print(num)

num2 = re.sub(pattern='-', repl='', string=num, count=0, flags=0)
print(num2)


def double(matched):
    value = int(matched.group('value'))
    return str(value * 2)


s = 'A23G4HFD567'
print(re.sub('(?P<value>\d+)', double, s))  
