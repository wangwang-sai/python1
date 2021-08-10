'''
    猜数字游戏：
        1.系统随机产生一个随机数字（0~1000）
        2.用户从键盘输入数字，与随机数字进行比对 （让用户循环输入20）
            若大了：温馨提示，大了
            若小了：温馨提示，小了
            猜中
        3.循环：一直到猜中为止，退出程序。
    技术分析：
    1.随机数
        random
    2.input
    3.判断
        if ...elif ...else
    4.循环
        while : 当型循环条件型循环
    5.退出程序
        break
    任务：
        加入初始化金币功能，猜错1次扣500金币。
        猜中直接奖励10000，询问是否继续第二轮随机数猜测。

        10次没猜中，系统直接锁定。
'''
# 1.让系统随机产生一个随机数
import random
num = random.randint(0,100)
money=100000
count = 0
# 只允许让用户输入20次
i = 1
while i<10:
    count = count + 1
    # 2. 让用户数据
    chose = input("请输入本次猜的数字：") # "123"  --> 123
    chose = int(chose)
    # 3.判断是否猜中
    if chose > num:
        print("大了！")
        money=money-500
        print("你的账户被扣除500当前余额为：",money)
        if money<=0:
            print("你没有钱了，bye")
            break
    elif chose < num:
        print("小了！")
        money=money-500
        print("你的账户被扣除500当前余额为：", money)
        if money <= 0:
            print("你没有钱了，bye")
            break
    elif chose==num:
        money=money+10000
        print("恭喜，本次猜中，本次幸运数字为：",num,"，本次猜了",count,"次")
        bye = input('是否继续？Y/N:')
        if bye == 'y':
            print("游戏继续。。。")
            num = random.randint(0, 100)
            count = 0
        else:
            print("bye")
            break
    else:
        print("游戏结束，game over")
        break










