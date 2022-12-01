# 需求：爬取知网的专利信息

import requests
# import xlsxwriter as xw
import os
import json

f_cn = open('cn.txt', 'a')
f_time = open('time.txt', 'a')
f_shenqing = open('申请人.txt', 'a')
f_faming = open('发明人.txt', 'a')
f_fenlei = open('分类号.txt', 'a')
f_zhufenlei = open('主分类号.txt', 'a')

class Zhanli(object):
    def __init__(self, cn):
        # 现在的url 会根据翻译的文本不同而变化
        self.CN = cn
        self.url = 'https://kns.cnki.net/kcms/detail/detail.aspx?dbcode=SCPD&dbname=SCPD2016&filename='+self.CN + \
                   '&uniplatform=NZKPT&v=Tzpd0QdIZGDC9HWtDkD_lQgZRK9zx0hNIMS0kZGaRm_RSRkmRO9ojhjHN70NS4NI'
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) '
                          'Chrome/107.0.0.0 Safari/537.36 Edg/107.0.1418.56'
        }

    def run_CN_A(self):
        global datetime, shenqing_name, zhufenlei_num, fenlei_num
        response = requests.get(self.url)
        data = str(response.content.decode())
        # print(type(data))
        # 需要的数据：
        # 申请公告日，申请人，发明人，分类号，主分类号
        index_title = data.find("<p style=\"margin:150px 0  20px;text-align:center;font-size:22px;\">")
        index_title_ = data.find("</p>")
        if data[index_title+len('<p style=\"margin:150px 0  20px;text-align:center;font-size:22px;\">'):index_title_] != "所查找的文献不存在":
            print(self.CN)
            f_cn.write(self.CN)

            index0 = data.find("申请公告日")
            index0_0 = data.find('</p>',index0)
            print(" 申请公告日:" + data[index0 + len('申请公告日：</span><p class="funds">'):index0_0])
            # datetime = data[index0 + len('申请公告日：</span><p class="funds">'):index0_0]
            f_time.write('\n'+data[index0 + len('申请公告日：</span><p class="funds">'):index0_0])

            index1 = data.find("TurnPageToKnetV('in','")  # 申请人
            if index1 != -1:
                index1_1 = data.find("',", index1+len("TurnPageToKnetV('in','"))  # TODO:: 这里需要重新思考一下
                print(" 申请人:" + data[index1 + len('TurnPageToKnetV(\'in\',\''):index1_1])
                # shenqing_name = data[index1 + len('TurnPageToKnetV(\'in\',\''):index1_1]
                f_shenqing.write('\n'+data[index1 + len('TurnPageToKnetV(\'in\',\''):index1_1], )
            else:
                index1 = data.find("申请人：</span><p class=\"funds\">")
                index1_1 = data.find("</p>", index1)
                print(" 申请人:" + data[index1 + len('申请人：</span><p class=\"funds\">'):index1_1])
                # shenqing_name = data[index1 + len('申请人：</span><p class=\"funds\">'):index1_1]
                f_shenqing.write('\n'+data[index1 + len('申请人：</span><p class=\"funds\">'):index1_1])

            index2 = 0
            index2 = data.find("TurnPageToKnetV('au'", index2 + 1)  # 发明人
            print(" 发明人:", end=' ')
            faming_name = []
            while True:
                if index2 != -1:
                    index2_2 = data.find("',", index2 + len("TurnPageToKnetV('au'"))  # TODO:: 这里需要重新思考一下
                    print(data[index2 + len("TurnPageToKnetV('au','"):index2_2], end=' ')
                    faming_name.append(data[index2 + len("TurnPageToKnetV('au','"):index2_2])
                    index2 = data.find("TurnPageToKnetV('au'", index2 + 1)  # 发明人
                    if index2 == -1:
                        print("")
                        faming_name.append('-1')
                        break
                else:
                    index2 = data.find("发明人：</span><p class=\"funds\">")
                    index2_2 = data.find("</p>", index2)
                    print(data[index2 + len("发明人：</span><p class=\"funds\">"):index2_2], end=' ')
                    faming_name.append(data[index2 + len("发明人：</span><p class=\"funds\">"):index2_2])
                    print('')
                    faming_name.append('-1')
                    break
            for i in faming_name:
                if i=='-1':
                    f_faming.write('\n')
                else:
                    f_faming.write(i)
                    f_faming.write(';')

            index3 = data.find("分类号")
            index3_3 = data.find('</p>', index3)
            print(" 分类号:" + data[index3 + len('分类号：</span><p class="funds">'):index3_3])
            # fenlei_num = data[index3 + len('分类号：</span><p class="funds">'):index3_3]
            f_fenlei.write('\n'+data[index3 + len('分类号：</span><p class="funds">'):index3_3])

            index4 = data.find('主分类号')
            index4_4 = data.find('</p>', index4)
            print(" 主分类号:"+data[index4+len('主分类号：</span><p class="funds">'):index4_4])
            # zhufenlei_num = data[index4+len('主分类号：</span><p class="funds">'):index4_4]
            f_zhufenlei.write('\n'+data[index4+len('主分类号：</span><p class="funds">'):index4_4])

            print("")
        # return [self.CN, datetime, shenqing_name, fenlei_num, zhufenlei_num]

    def run_CN_U(self):
        response = requests.get(self.url)
        data = str(response.content.decode())
        # print(type(data))
        # 需要的数据：
        # 申请公告日，申请人，发明人，分类号，主分类号
        index_title = data.find("<p style=\"margin:150px 0  20px;text-align:center;font-size:22px;\">")
        index_title_ = data.find("</p>")
        if data[index_title + len('<p style=\"margin:150px 0  20px;text-align:center;font-size:22px;\">'):index_title_] != "所查找的文献不存在":
            print(self.CN)
            f_cn.write(self.CN)

            index0 = data.find("授权公告日")
            index0_0 = data.find('</p>', index0)
            print(" 授权公告日:" + data[index0 + len('授权公告日：</span><p class="funds">'):index0_0])
            # datetime = data[index0 + len('授权公告日：</span><p class="funds">'):index0_0]
            f_time.write('\n'+data[index0 + len('授权公告日：</span><p class="funds">'):index0_0])

            index1 = data.find("TurnPageToKnetV('in','")  # 申请人
            if index1 != -1:
                index1_1 = data.find("',", index1 + len("TurnPageToKnetV('in','"))  # TODO:: 这里需要重新思考一下
                print(" 申请人:" + data[index1 + len('TurnPageToKnetV(\'in\',\''):index1_1])
                # shenqing_name = data[index1 + len('TurnPageToKnetV(\'in\',\''):index1_1]
                f_shenqing.write('\n'+data[index1 + len('TurnPageToKnetV(\'in\',\''):index1_1])
            else:
                index1 = data.find("申请人：</span><p class=\"funds\">")
                index1_1 = data.find("</p>", index1)
                print(" 申请人:" + data[index1 + len('申请人：</span><p class=\"funds\">'):index1_1])
                # shenqing_name = data[index1 + len('申请人：</span><p class=\"funds\">'):index1_1]
                f_shenqing.write('\n'+data[index1 + len('申请人：</span><p class=\"funds\">'):index1_1])

            index2 = 0
            index2 = data.find("TurnPageToKnetV('au'", index2 + 1)  # 发明人
            print(" 发明人:", end=' ')
            faming_name = []
            while True:
                if index2 != -1:
                    index2_2 = data.find("',", index2 + len("TurnPageToKnetV('au'"))  # TODO:: 这里需要重新思考一下
                    print(data[index2 + len("TurnPageToKnetV('au','"):index2_2], end=' ')
                    faming_name.append(data[index2 + len("TurnPageToKnetV('au','"):index2_2])
                    index2 = data.find("TurnPageToKnetV('au'", index2 + 1)  # 发明人
                    if index2 == -1:
                        print("")
                        faming_name.append('-1')
                        break
                else:
                    index2 = data.find("发明人：</span><p class=\"funds\">")
                    index2_2 = data.find("</p>", index2)
                    print(data[index2 + len("发明人：</span><p class=\"funds\">"):index2_2], end=' ')
                    faming_name.append(data[index2 + len("发明人：</span><p class=\"funds\">"):index2_2])
                    print('')
                    faming_name.append('-1')
                    break
            for i in faming_name:
                if i=='-1':
                    f_faming.write('\n')
                else:
                    f_faming.write(i)
                    f_faming.write(';')

            index3 = data.find("分类号")
            index3_3 = data.find('</p>', index3)
            print(" 分类号:" + data[index3 + len('分类号：</span><p class="funds">'):index3_3])
            # fenlei_num = data[index3 + len('分类号：</span><p class="funds">'):index3_3]
            f_fenlei.write('\n'+data[index3 + len('分类号：</span><p class="funds">'):index3_3])

            index4 = data.find('主分类号')
            index4_4 = data.find('</p>', index4)
            print(" 主分类号:" + data[index4 + len('主分类号：</span><p class="funds">'):index4_4])
            # zhufenlei_num = data[index4 + len('主分类号：</span><p class="funds">'):index4_4]
            f_zhufenlei.write('\n'+data[index4 + len('主分类号：</span><p class="funds">'):index4_4])

            print("")
            # return [self.CN, datetime, shenqing_name, fenlei_num, zhufenlei_num]


if __name__ == '__main__':
    f = open("cn.data",'r')
    # content = f.readline()
    while True:
        content = f.readline()
        if content == '':
            break
        else:
            if content[-2:-1] == 'A':
                zhuanli = Zhanli(cn=content)
                zhuanli.run_CN_A()

            elif content[-2:-1] == "U":
                zhuanli = Zhanli(cn=content)
                zhuanli.run_CN_U()
    f.close()





