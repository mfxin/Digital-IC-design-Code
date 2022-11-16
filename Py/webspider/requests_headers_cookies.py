import requests

url = 'https://mail.stu.xidian.edu.cn/coremail/XT5/index.jsp?sid=BAIgjivvnvrIFTRPakWpIomXmOXBqsAS#mail.welcome'
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 '
                  'Safari/537.36 Edg/107.0.1418.42 ',
    # 'Cookie': 'face=auto; locale=zh_CN; saveUsername=true; uid=18140200072%40stu.xidian.edu.cn; '
    #           'domain=stu.xidian.edu.cn; id=234551430; UID=234551430; fid=16820; vc=c7bc2de1c042b4a9659e3040a90d4da4; '
    #           'isfyportal=1; fanyamoocs=1C53AFAA48BC5E82DB1C8DCB83952225; _dd234551430=1668587574107; '
    #           'CoremailReferer=https%3A%2F%2Fmail.stu.xidian.edu.cn%2Fcoremail%2F; '
    #           'Coremail=4d66430abf3d5f564d126a551faa18b6; Coremail.sid=BAIgjivvnvrIFTRPakWpIomXmOXBqsAS '
}

temp = 'face=auto; locale=zh_CN; saveUsername=true; uid=18140200072@stu.xidian.edu.cn; domain=stu.xidian.edu.cn; ' \
       'id=234551430; UID=234551430; fid=16820; vc=c7bc2de1c042b4a9659e3040a90d4da4; isfyportal=1; ' \
       'fanyamoocs=1C53AFAA48BC5E82DB1C8DCB83952225; _dd234551430=1668587574107; ' \
       'CoremailReferer=https://mail.stu.xidian.edu.cn/coremail/; Coremail=4d66430abf3d5f564d126a551faa18b6; ' \
       'Coremail.sid=BAIgjivvnvrIFTRPakWpIomXmOXBqsAS '

cookie_list = temp.split('; ')
print(cookie_list)
# 炫技
# cookies = {cookie.split('=')[0]:cookie.split('=')[-1] for cookie in cookie_list}
# 稳妥
cookies = {}
for cookie in cookie_list:
    cookies[cookie.split('=')[0]] = cookie.split('=')[-1]

response = requests.get(url, headers=headers,cookies=cookies)
print(response.content.decode())
index1 = response.content.decode().find('<title>')
index2 = response.content.decode().rfind('</title>')
print(index1)
print(index2)
print(type(response.content.decode()))
for i in response.content.decode()[index1+len('<title>'):index2]:
    print(i, end='')
print(response.content.decode().find('孟凡鑫'))

