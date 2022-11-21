# TODO:: 自动保持cookie 进行状态保持
# 使用场景：连续多次请求

import requests
import re


def login():
    # session
    session = requests.session()
    # headers
    session.headers = {
        'User-Agent': 'Mozilla / 5.0(Windows NT 10.0; Win64; x64) AppleWebKit / 537.36(KHTML, like Gecko) Chrome / '
                      '107.0.0.0 Safari / 537.36 '
    }
    # url1-获取token
    url1 = 'https://mail.stu.xidian.edu.cn/coremail/'
    token = re('')
    # url2-登录
    # url3-验证


if __name__ == "__main__":
    login()




