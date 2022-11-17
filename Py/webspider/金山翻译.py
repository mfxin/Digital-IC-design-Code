import requests
import json


class JinShan(object):
    def __init__(self, word):
        # 现在的url 会根据翻译的文本不同而变化
        self.url = 'http://ifanyi.iciba.com/index.php?c=trans&m=fy&client=6&auth_user=key_web_fanyi&sign=3cef5d7c832134e1'
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) '
                          'Chrome/107.0.0.0 Safari/537.36',
            # 'Cookie': 'BAIDU_SSP_lcr=https://cn.bing.com/; __bid_n=184835826bdf3e57fa4207'
        }
        self.data = {
            'from': 'zh',
            'to': 'en',
            'q': word
        }

    def get_data(self):
        response = requests.post(self.url, data=self.data, headers=self.headers)
        return response.content

    def parse_data(self, data):
        dict_data = json.loads(data)
        print(dict_data['content']['out'])

    def run(self):
        # 编写逻辑

        # url
        # headers
        # data 字典
        # 发送请求 获取响应
        response = self.get_data()
        self.parse_data(response)


if __name__ == '__main__':
    # word = input('输入需要翻译的中文：')
    jinshan = JinShan('悲剧')
    jinshan.run()




