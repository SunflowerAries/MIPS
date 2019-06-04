import random
import re
def generate(num=128):
    f = open("./data.bak", 'w+')
    i = 0
    while i < num:
        rand = random.randint(0, 9)
        print("RAM[%d] <= 32'h%d;"%(i, rand), file=f)
        i += 1

def sum(stride=1, num=128):
    list = []
    with open('data.bak', 'r', encoding='utf-8') as f:
        sum = 0
        for line in f.readlines():
            sum += int(re.findall(r"32'h(.+);", line)[0])
            list.append(int(re.findall(r"32'h(.+);", line)[0]))
        print(hex(sum))

    sum = 0
    for i in range(stride):
        for j in range(int(num/stride)):
            sum += list[i + j*stride]
            print(list[i + j*stride], hex(sum))

# generate(num=128)
sum(stride=8, num=128)
