import re

# re.match(pattern, string, flags)  需要从开头进行匹配
# pattern 匹配的正则表达式
# string 需要匹配的字符串
# flags 标志位，控制正则表达式的匹配方式，如 是否区分大小写(flags=re.I 不区分大小写)，多行匹配等等
string = 'i am a student.'
print(re.match(pattern='I', string=string, flags=re.I))  # 匹配成功 re.match 方法返回一个匹配的对象，否则返回 None。

# 使用 group(num) 或 groups() 匹配对象函数来获取匹配表达式
print(re.match(pattern='I', string=string, flags=re.I).span())  # 匹配成功 返回匹配的索引值
print(re.match(pattern='I', string=string, flags=re.I).group())  # 匹配成功 返回匹配的元素

print(re.match(pattern='i', string=string, flags=re.I).groups())  # 匹配成功 返回一个包含所有小组字符串的元组，从 1 到 所含的小组号。

line = "Cats are smarter than dogs"

matchObj = re.match('(.*) are (.*?) .*', line, re.M | re.I)


if matchObj:
    print("matchObj.group() : ", matchObj.group())
    print("matchObj.group(1) : ", matchObj.group(1))
    print("matchObj.group(2) : ", matchObj.group(2))
else:
    print("No match!!")


# re.match只匹配字符串的开始，如果字符串开始不符合正则表达式，则匹配失败，函数返回None；而re.search匹配整个字符串，直到找到一个匹配。

matchObj_s = re.search('are', line, flags=0)
print(matchObj_s.group())
print(matchObj_s.span())
# matchObj_m = re.match('are', line, flags=0)
# print(matchObj_m.group())





