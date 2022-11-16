import requests

# url = "http://www.baidu.com/s?wd=python"
url = "http://www.baidu.com/s?"

data = {
    'wd': 'python'
}

headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) '
                         'Chrome/107.0.0.0 Safari/537.36'}


response = requests.get(url, headers=headers, params=data)
print(response.url)
with open('baidu.html', 'wb') as f:
    f.write(response.content)

# response.encoding = "utf8"
# print(response.text)

# print(response.content.decode())
#
# print(response.url)
# print(response.status_code)
# print(response.request.headers)  # 请求头
# print(response.headers)  # 响应头
#
# print(response.cookies)
# print(len(response.content.decode()))
# print(response.content.decode())

