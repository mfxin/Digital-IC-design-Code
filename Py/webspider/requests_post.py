import requests
import json
import sys


class YouDao(object):
    def __init__(self, word):
        self.url = 'https://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule'
        self.headers = {
            'User-Agent': 'Mozilla/5.0(Windows NT 10.0; Win64; x64) AppleWebKit / 537.36 (KHTML, like Gecko) '
                          'Chrome/107.0.0.0 Safari / 537.36 '
        }
        self.data = {
            'i': word,
            'from': 'AUTO',
            'to': 'AUTO',
            'smartresult': 'dict',
            'client': 'fanyideskweb',
            'salt': '16686494048754',
            'sign': 'aeec84b1f244d6797f1698b873c72c0c',
            'lts': '1668649404875',
            'bv': '9edd1e630b7d8f13679a536d504f3d9f',
            'doctype': 'json',
            'version': '2.1',
            'keyfrom': 'fanyi.web',
            'action': 'FY_BY_REALTlME'
        }

    def get_data(self):
        response = requests.post(self.url, data=self.data, headers=self.headers)
        return response.content

    def parse_data(self, data):
        dict_data = json.loads(data)
        print(dict_data['translateResult'][0][0]['tgt'])

    def run(self):
        # 编写逻辑

        # url
        # headers
        # data 字典
        # 发送请求 获取响应
        response = self.get_data()
        self.parse_data(response)
        # print(response)


if __name__ == '__main__':
    # print(sys.argv)
    '''命令行实现翻译'''
    word = sys.argv[1]

    youdao = YouDao(word)
    youdao.run()

    '''循环翻译'''
    # while True:
    #     word = input("输入你需要翻译的内容：")
    #     if word == '-1':
    #         break
    #     else:
    #         youdao = YouDao(word)
    #         youdao.run()
