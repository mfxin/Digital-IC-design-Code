import requests

url = 'https://fanyi.youdao.com/'

headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) '
                         'Chrome/107.0.0.0 Safari/537.36 Edg/107.0.1418.42'
           }

response = requests.get(url, headers=headers)
data = response.content.decode()
print(data)


