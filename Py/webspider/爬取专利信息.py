# 需求：爬取知网的专利信息

import requests
# import xlsxwriter as xw
import xlwt
import os
import json



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
            f_time.write(data[index0 + len('申请公告日：</span><p class="funds">'):index0_0]+'\n')

            index1 = data.find("TurnPageToKnetV('in','")  # 申请人
            if index1 != -1:
                index1_1 = data.find("',", index1+len("TurnPageToKnetV('in','"))  # TODO:: 这里需要重新思考一下
                print(" 申请人:" + data[index1 + len('TurnPageToKnetV(\'in\',\''):index1_1])
                # shenqing_name = data[index1 + len('TurnPageToKnetV(\'in\',\''):index1_1]
                f_shenqing.write(data[index1 + len('TurnPageToKnetV(\'in\',\''):index1_1]+'\n')
            else:
                index1 = data.find("申请人：</span><p class=\"funds\">")
                index1_1 = data.find("</p>", index1)
                print(" 申请人:" + data[index1 + len('申请人：</span><p class=\"funds\">'):index1_1])
                # shenqing_name = data[index1 + len('申请人：</span><p class=\"funds\">'):index1_1]
                f_shenqing.write(data[index1 + len('申请人：</span><p class=\"funds\">'):index1_1]+'\n')

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
            f_fenlei.write(data[index3 + len('分类号：</span><p class="funds">'):index3_3]+'\n')

            index4 = data.find('主分类号')
            index4_4 = data.find('</p>', index4)
            print(" 主分类号:"+data[index4+len('主分类号：</span><p class="funds">'):index4_4])
            # zhufenlei_num = data[index4+len('主分类号：</span><p class="funds">'):index4_4]
            f_zhufenlei.write(data[index4+len('主分类号：</span><p class="funds">'):index4_4]+'\n')

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
            f_time.write(data[index0 + len('授权公告日：</span><p class="funds">'):index0_0]+'\n')

            index1 = data.find("TurnPageToKnetV('in','")  # 申请人
            if index1 != -1:
                index1_1 = data.find("',", index1 + len("TurnPageToKnetV('in','"))  # TODO:: 这里需要重新思考一下
                print(" 申请人:" + data[index1 + len('TurnPageToKnetV(\'in\',\''):index1_1])
                # shenqing_name = data[index1 + len('TurnPageToKnetV(\'in\',\''):index1_1]
                f_shenqing.write(data[index1 + len('TurnPageToKnetV(\'in\',\''):index1_1]+'\n')
            else:
                index1 = data.find("申请人：</span><p class=\"funds\">")
                index1_1 = data.find("</p>", index1)
                print(" 申请人:" + data[index1 + len('申请人：</span><p class=\"funds\">'):index1_1])
                # shenqing_name = data[index1 + len('申请人：</span><p class=\"funds\">'):index1_1]
                f_shenqing.write(data[index1 + len('申请人：</span><p class=\"funds\">'):index1_1]+'\n')

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
            f_fenlei.write(data[index3 + len('分类号：</span><p class="funds">'):index3_3]+'\n')

            index4 = data.find('主分类号')
            index4_4 = data.find('</p>', index4)
            print(" 主分类号:" + data[index4 + len('主分类号：</span><p class="funds">'):index4_4])
            # zhufenlei_num = data[index4 + len('主分类号：</span><p class="funds">'):index4_4]
            f_zhufenlei.write(data[index4 + len('主分类号：</span><p class="funds">'):index4_4]+'\n')

            print("")
            # return [self.CN, datetime, shenqing_name, fenlei_num, zhufenlei_num]


if __name__ == '__main__':

    f_cn = open('cn.txt', 'w+')
    f_time = open('time.txt', 'w+')
    f_shenqing = open('申请人.txt', 'w+')
    f_faming = open('发明人.txt', 'w+')
    f_fenlei = open('分类号.txt', 'w+')
    f_zhufenlei = open('主分类号.txt', 'w+')

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
    f_shenqing.close()
    f_faming.close()
    f_time.close()
    f_cn.close()
    f_zhufenlei.close()
    f_fenlei.close()

    f_cn = open('cn.txt', 'r')
    f_time = open('time.txt', 'r')
    f_shenqing = open('申请人.txt', 'r')
    f_faming = open('发明人.txt', 'r')
    f_fenlei = open('分类号.txt', 'r')
    f_zhufenlei = open('主分类号.txt', 'r')

    # 将数据写入excel
    print("开始写excel")
    book = xlwt.Workbook(encoding='utf-8')
    sheet = book.add_sheet('sheet1', cell_overwrite_ok=True)

    print("正在写excel")
    i = 0
    for word in f_cn:
        print(word)
        sheet.write(i, 0, word)
        i=i+1

    j = 0
    for word in f_time:
        print(word)
        sheet.write(j, 1, word)
        j=j+1
    m = 0
    for word in f_shenqing:
        print(word)
        sheet.write(m, 2, word)
        m=m+1
        print(m)
    n = 0
    for word in f_faming:
        print(word)
        sheet.write(n, 3, word)
        n=n+1
    p = 0
    for word in f_fenlei:
        print(word)
        sheet.write(p, 4, word)
        p=p+1
    q = 0
    for word in f_zhufenlei:
        print(word)
        sheet.write(q, 5, word)
        q=q+1

    book.save('整合信息reallyfinal.xls')
    print("写完并保存excel")

    f_shenqing.close()
    f_faming.close()
    f_time.close()
    f_cn.close()
    f_zhufenlei.close()
    f_fenlei.close()

    os.remove('cn.txt')
    os.remove('time.txt')
    os.remove('申请人.txt')
    os.remove('发明人.txt')
    os.remove('分类号.txt')
    os.remove('主分类号.txt')

