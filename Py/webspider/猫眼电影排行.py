import requests


class Moive():
    def __init__(self):
        self.num = 0

        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) '
                          'Chrome/107.0.0.0 '
                          'Safari/537.36 Edg/107.0.1418.42 '
        }

    def run(self):
        while True:
            self.num += 1
            if self.num == 11:
                break
            url = 'https://ssr1.scrape.center/page/' + str(self.num)
            responses = requests.get(url, headers=self.headers)
            data = str(responses.content.decode())

            # 查找字符串
            word = '<h2 data-v-7f856186="" class="m-b-sm">'
            word2 = '</h2>'

            list1 = []
            list2 = []

            index1 = data.find(word)
            index2 = data.find(word2)

            list1.append(index1)
            list2.append(index2)

            while word in data[index1 + 1:]:
                index_new = data[index1 + 1:].find(word)
                index1 = index_new + 1 + index1
                list1.append(index1)

            while word2 in data[index2 + 1:]:
                index_new2 = data[index2 + 1:].find(word2)
                index2 = index_new2 + 1 + index2
                list2.append(index2)

            for i in range(len(list1)):
                newdata = data[list1[i] + len(word):list2[i]]
                print(newdata)


if __name__ == '__main__':
    moive = Moive()
    moive.run()
